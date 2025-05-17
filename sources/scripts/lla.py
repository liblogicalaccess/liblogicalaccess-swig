#!/usr/bin/env python

import sys
import os
import glob
import re
import clang.cindex
from multiprocessing.pool import Pool
from functools import partial
import logging
import enum


# Known issues:
#   + Template instantiation through inheritance tree are not detected. Therefore
#     SAMCommand<> templates have been manually written into the corresponding '.i' file.
#   + Include processing is regex based, and therefore is not aware of possible preprocessor if/else
#     that could prevent an include.


if os.name == 'posix':
    clang.cindex.Config.set_library_file('/usr/lib/llvm-19/lib/libclang.so')
else:
    clang.cindex.Config.set_library_file('C:\\Program Files\\LLVM\\bin\\libclang.dll')
    logging.basicConfig(level=logging.INFO)

# Types that we explicitly do not declare as usable through shared_ptr.
IGNORED_TYPES = ['logicalaccess::MifareAccessInfo::DataBlockAccessBits',
                 'logicalaccess::MifareAccessInfo::BlockAccessBits',
                 'logicalaccess::MifareAccessInfo::SectorTrailerAccessBits',
                 'logicalaccess::KeyboardEntry']

LLA_INCLUDE_PATH = '../../installer/packages/include/'

class LLACategory(enum.Enum):
    """
    Category that we have defined when "grouping" files. Those will end-up in
    different namespace in CSharp code.
    """
    CARDS = 1
    READERS = 2
    CORE = 3
    CRYPTO = 4


class SwigCategory(enum.Enum):
    """
    Swig has %include and %import directives that have different meaning.
    This enum help distinguish them.
    """
    IMPORT = 1
    INCLUDE = 2


def get_clang_define_list(lla_api_defines):
    result = []
    for lla_api_define in lla_api_defines:
        result.append("-D{}=".format(lla_api_define))
    return result

def clean_swig_file(filename):
    """
    Clean a single file, remove supposed generated content for previous run.
    """
    logging.info('Cleaning file {}'.format(filename))
    with open(filename, "r") as f:
        lines = f.readlines()

        try:
            a = lines.index("/* Additional_include */\n") + 1
            while a != lines.index("/* END_Additional_include */\n") - 1:
                del lines[a]
        except ValueError:
            pass

        try:
            a = lines.index("/* Include_section */\n") + 1
            while a != lines.index("/* END_Include_section */\n") - 1:
                del lines[a]
        except ValueError:
            pass

        try:
            i = lines.index("/*****SHARED PTR SECTION*****/\n") + 1
            while i != lines.index("/*** MULTIPLE INHERITANCE ***/\n") - 1:
                del lines[i]
        except ValueError:
            pass

        try:
            i = lines.index("/* Define_section */\n") + 1
            while i != lines.index("/* END_Define_section */\n") - 1:
                del lines[i]
        except ValueError:
            pass

    with open(filename, "w") as f:
        f.write(''.join(lines))


def clean_files(swig_file_root):
    """
    Remove generated content between placeholders.
    :param swig_file_root:
    :return:
    """
    for f in glob.glob('{}/*.i'.format(swig_file_root)):
        # It seems we specifically ignore liblogicalaccess_card_sam.i
        # as it was manually generated ?
        if f.endswith('liblogicalaccess_card_sam.i'):  # or f.endswith('liblogicalaccess_crypto.i'):
            continue
        clean_swig_file(f)


def parse_translation_unit(filename, lla_api_defines):
    """
    Not really a Translation Unit, most likely an header file.
    :return: A TranslationUnit clang object.
    """
    index = clang.cindex.Index.create()
    options = clang.cindex.TranslationUnit.PARSE_SKIP_FUNCTION_BODIES | clang.cindex.TranslationUnit.PARSE_INCOMPLETE | clang.cindex.TranslationUnit.PARSE_DETAILED_PROCESSING_RECORD
    tu = index.parse(filename, ['-x', 'c++', '-std=c++14',
                                '-I{}'.format(LLA_INCLUDE_PATH)] + lla_api_defines,
                     unsaved_files=None, options=options)
    return tu


def find_namespaces(node):
    """
    Retrieve the namespaces of a class / struct declaration.
    The namespaces are contained in a list. If there is multiple nested
    namespace, the first element in the list is the outermost namespace.
    :param node: Clang node
    :return: ['logicalaccess, 'openssl']
    """
    assert node.kind == clang.cindex.CursorKind.CLASS_DECL or \
           node.kind == clang.cindex.CursorKind.STRUCT_DECL

    namespaces = []
    parent = node.semantic_parent
    while parent and parent.semantic_parent:
        if parent.kind == clang.cindex.CursorKind.NAMESPACE or \
                parent.kind == clang.cindex.CursorKind.CLASS_DECL or \
                parent.kind == clang.cindex.CursorKind.STRUCT_DECL:
            namespaces = [parent.spelling] + namespaces
        parent = parent.semantic_parent
    return namespaces


def is_lla_namespace(node):
    namespaces = find_namespaces(node)
    return len(namespaces) and namespaces[0] == 'logicalaccess'


# Unused.
def find_template_parents(classdecl_node):
    """
    Iterate through the parents of a class, checking for Class Template parents.
    Template Instanciation (record) are then returned to be explicitely added as a
    known type.

    Indeed, MyClassTemplate<> is a concrete type, while MyClassTemplate<int> is.
    We do that for parent, maybe we will need to it against variable definition too.
    :return: set({MyClassTemplate<int>, ...})
    """
    # assert classdecl_node.kind == clang.cindex.CursorKind.CLASS_DECL or \
    #       classdecl_node.kind == clang.cindex.CursorKind.STRUCT_DECL

    print("Looking for parent of \"{}\"".format(classdecl_node.type.spelling))
    verbose = (classdecl_node.spelling == 'SAMISO7816Commands')
    templates = set()
    for node in classdecl_node.get_children():
        if node.kind == clang.cindex.CursorKind.CXX_BASE_SPECIFIER:
            if verbose or True:
                print('CXX_BASE of {} is {}'.format(classdecl_node.type.spelling, node.get_definition().type.spelling))
            parent_class_decl = node.get_definition()
            # Check that the parent is an LogicalAccess type.
            if is_lla_namespace(parent_class_decl) or True:
                # Get type of parent class declaration and check if its a template class
                if parent_class_decl.type.get_num_template_arguments() > 0:
                    templates.add(parent_class_decl.type.spelling)
                    # Manual tests.
                    for x in parent_class_decl.get_children():
                        print('{} -> {}'.format(x.kind, x.spelling))
                else:
                    templates |= find_template_parents(parent_class_decl)
    return templates


def gather_lla_types(node):
    """
    Iterate over a node's children looking for C++ struct or class declaration in order to
    gather LLA declared types.
    """

    types = set()
    for child_node in node.get_children():
        if child_node.kind == clang.cindex.CursorKind.CLASS_DECL or \
                child_node.kind == clang.cindex.CursorKind.STRUCT_DECL:

            if len(child_node.spelling) == 0:
                continue

            if is_lla_namespace(child_node):
                full_namespaces = find_namespaces(child_node)

                fqn = '::'.join(full_namespaces) + '::' + child_node.spelling
                if fqn not in IGNORED_TYPES:
                    types.add(fqn)

        types |= gather_lla_types(child_node)
    return types


def gather_includes(filename, includes, ignore_list):
    """
    Retrieve nested include from a file.

    For a given file we retrieve included filename, depth first.
    So if FileA includes files B includes file C, we will return [C, B, A]. This is
    important because the order matters for Swig.

    The distinction between Import and Include is performed later.
    """
    regex_include = r"(?<=#include [\"<])(.*?.hpp)(?=[\">]\n)"

    files_to_check_next = []
    with open(filename, "r", encoding='utf-8') as f:
        content = f.read()
        regex = re.findall(regex_include, content)
        for inc in regex:
            if inc in includes or not inc.startswith('logicalaccess'):
                continue
            files_to_check_next.append(inc)

    for f in files_to_check_next:
        if f in ignore_list:
            continue
        ignore_list.append(f)
        gather_includes(LLA_INCLUDE_PATH + f, includes, ignore_list)
        ignore_list.pop()
        if f not in includes and f not in ignore_list:
            includes.append(f)
    x = filename.replace(LLA_INCLUDE_PATH, '')
    if x not in includes and x not in ignore_list:
        includes.append(x)

    return includes


def process_file(lla_api_defines, filename):
    logging.info('Processing {}'.format(filename))
    tu = parse_translation_unit(filename, lla_api_defines)
    return gather_lla_types(tu.cursor)


class SearchResult:
    def __init__(self):
        self.types = set()

        # File that are '#include' into the Swig '.i' file.
        self.includes = []  # #include files

        self.swig_includes = set()  # %include files
        self.imports = set()

        # List of include / import in a tuple (SwigCategory / filepath).
        # This list is ordered and includes / imports must be written in
        # the given order.
        self.magic = []

    def add_include_import(self, filename, import_or_include):
        if import_or_include == SwigCategory.IMPORT:
            if filename not in self.imports:
                self.imports.add(filename)
                self.magic.append((SwigCategory.IMPORT, filename))
        if import_or_include == SwigCategory.INCLUDE:
            if filename not in self.swig_includes:
                self.swig_includes.add(filename)
                self.magic.append((SwigCategory.INCLUDE, filename))


def find_lla_infos(glob_string, category, lla_api_defines):
    """
    Recursively parse headers from source_root and extract LogicalAccess types.
    :return:
    """
    with Pool() as p:
        files = set()
        if isinstance(glob_string, list):
            for glob_str in glob_string:
                files |= set(glob.glob(glob_str, recursive=True))
        else:
            files = glob.glob(glob_string, recursive=True)
        files = [f.replace("\\", "/") for f in files]
        files = sorted(list(files))
        search_result = SearchResult()
        for f in files:
            for r in gather_includes(f, [], []):
                file_full = LLA_INCLUDE_PATH + r
                if category == LLACategory.CARDS or category == LLACategory.READERS or category == LLACategory.CRYPTO:
                    # For plugins, we add our own file (part of file group, aka matched by glob_string)
                    # to the files to be %include.
                    if file_full in files:
                        search_result.add_include_import(r, SwigCategory.INCLUDE)

                    # All files in /plugins/ are added to be #include
                    if r.find('/plugins/') != -1:
                        if r not in search_result.includes:
                            search_result.includes.append(r)

                    # Files in /plugins, but not our own (ie, card plugins when processing reader files)
                    # are added to be %import.
                    if r.find('/plugins/') != -1 and file_full not in files:
                        search_result.add_include_import(r, SwigCategory.IMPORT)

                elif category == LLACategory.CORE:
                    if file_full in files:
                        search_result.add_include_import(r, SwigCategory.INCLUDE)

                    if r.find('/plugins/') == -1:
                        if r not in search_result.includes:
                            search_result.includes.append(r)
                    else:
                        search_result.add_include_import(r, SwigCategory.IMPORT)

        lla_api_defines = get_clang_define_list(lla_api_defines)
        func = partial(process_file, lla_api_defines)
        ret = p.map(func, files)
        for r in ret:
            for type in r:
                search_result.types.add(type)
        return search_result


def write_for_module(module_name, search_result):
    """
    Write includes and import into the "module" file, liblogicalaccess_module_name.i.
    """
    filename = '../LibLogicalAccessNet.native/liblogicalaccess_{}.i'.format(module_name)

    with open(filename, "r") as f:
        lines = f.readlines()
    i = 0
    while i < len(lines):
        if "/* Additional_include */\n" in lines[i]:
            i += 2
            for include in search_result.includes:
                include = include.replace(LLA_INCLUDE_PATH, '')
                lines.insert(i, "#include <{}>\n".format(include))
                i += 1
            lines.insert(i, "\n")
            i += 1
        if "/* Include_section */\n" in lines[i]:
            i += 2
            for swig_category, filepath in search_result.magic:
                if swig_category == SwigCategory.IMPORT:
                    lines.insert(i, "%import <{}>\n".format(filepath))
                else:
                    lines.insert(i, "%include <{}>\n".format(filepath))
                i += 1
            lines.insert(i, "\n")
            i += 1
        i += 1
    with open(filename, "w") as f:
        f.write(''.join(lines))


def write_shared_ptr(all_types):
    """
    Write the %shared_ptr() declaration into liblogicalaccess.i for all known types.
    :param all_types:
    :return:
    """
    path = "../LibLogicalAccessNet.native/liblogicalaccess.i"
    with open(path, "r") as f:
        lines = f.readlines()
        i = lines.index("/*****SHARED PTR SECTION*****/\n") + 1
        while i != lines.index("/*** MULTIPLE INHERITANCE ***/\n") - 1:
            del lines[i]
    i = lines.index("/*****SHARED PTR SECTION*****/\n") + 1
    lines.insert(i, "\n")
    i += 1

    all_types = list(all_types)
    all_types.sort()
    for t in all_types:
        # Temporary workaround for latest clang versions, we should better call libclang instead
        if "(unnamed struct at" not in t:
            lines.insert(i, "%shared_ptr(" + t + ");" + "\n")
            i += 1
    for t in all_types:
        print('SPTR: {}'.format(t))
        # Temporary workaround for latest clang versions, we should better call libclang instead
        if "(unnamed struct at" not in t:
            lines.insert(i, "%shared_ptr(" + t.replace('logicalaccess::', '') + ");" + "\n")
            i += 1
    with open(path, "w") as f:
        f.write(''.join(lines))

def find_lla_api_define(glob_string):
    """
    Recursively parse headers from source_root and extract LogicalAccess API define types.
    Write the define in swig interface and store them for clang
    :return:
    """
    files = glob.glob(glob_string, recursive=True)
    lla_api_defines = []
    for file in files:
        with open(file, "r") as f:
            lines = f.readlines()
            define_api = re.search('#  define (.+?)\n', lines[5]).group(1)
            lla_api_defines.append(define_api)
    lla_api_defines = list(set(lla_api_defines))
    lla_api_defines.sort()
    return lla_api_defines

def write_lla_api_define(lla_api_defines):
    """
    Write the lla api define in swig interface
    :return:
    """
    path = "../LibLogicalAccessNet.native/liblogicalaccess.i"
    with open(path, "r") as f:
        lines = f.readlines()

    i = lines.index("/* Define_section */\n") + 1
    for lla_api_define in lla_api_defines:
        lines.insert(i, "#define {}\n".format(lla_api_define))
    lines.insert(i, "\n")

    with open(path, "w") as f:
        f.write(''.join(lines))

def main():
    clean_files('../LibLogicalAccessNet.native/')

    lla_api_defines = find_lla_api_define('{}logicalaccess/**/lla_*_api.hpp'.format(LLA_INCLUDE_PATH))
    write_lla_api_define(lla_api_defines)

    crypto_module_result = find_lla_infos('{}logicalaccess/plugins/crypto/**/*.hpp'.format(LLA_INCLUDE_PATH),
                                          LLACategory.CRYPTO, lla_api_defines)
    write_for_module('crypto', crypto_module_result)

    card_module_result = find_lla_infos('{}logicalaccess/plugins/cards/**/*.hpp'.format(LLA_INCLUDE_PATH),
                                        LLACategory.CARDS, lla_api_defines)
    write_for_module('card', card_module_result)

    reader_module_result = find_lla_infos('{}logicalaccess/plugins/readers/**/*.hpp'.format(LLA_INCLUDE_PATH),
                                          LLACategory.READERS, lla_api_defines)
    write_for_module('reader', reader_module_result)

    core_module_result = find_lla_infos(['{}logicalaccess/cards/**/*.hpp'.format(LLA_INCLUDE_PATH),
                                         '{}logicalaccess/services/**/*.hpp'.format(LLA_INCLUDE_PATH),
                                         '{}logicalaccess/readerproviders/**/*.hpp'.format(LLA_INCLUDE_PATH),
                                         '{}logicalaccess/*.hpp'.format(LLA_INCLUDE_PATH)],
                                        LLACategory.CORE, lla_api_defines)
    write_for_module('core', core_module_result)

    # Types
    all_types = card_module_result.types | reader_module_result.types | core_module_result.types | crypto_module_result.types
    write_shared_ptr(all_types)


if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)
    main()
