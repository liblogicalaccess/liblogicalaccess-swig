#!/usr/bin/env python

import sys
import os
import glob
import re
import clang.cindex
from multiprocessing.pool import Pool
import logging


def arglist_disable_export_macros():
    return ['-DLLA_CORE_API=',
            '-DLLA_CARDS_CPS3_API=',
            '-DLLA_CARDS_DESFIRE_API=',
            '-DLLA_CARDS_EM4102_API=',
            '-DLLA_CARDS_EM4135_API=',
            '-DLLA_CARDS_EPASS_API=',
            '-DLLA_CARDS_FELICA_API=',
            '-DLLA_CARDS_GENERICTAG_API=',
            '-DLLA_CARDS_ICODE1_API=',
            '-DLLA_CARDS_ICODE2_API=',
            '-DLLA_CARDS_INDALA_API=',
            '-DLLA_CARDS_INFINEONMYD_API=',
            '-DLLA_CARDS_ISO15693_API=',
            '-DLLA_CARDS_ISO7816_API=',
            '-DLLA_READERS_PRIVATE_KEYBOARD_API=',
            '-DLLA_CARDS_LEGICPRIME_API=',
            '-DLLA_CARDS_MIFARE_API=',
            '-DLLA_CARDS_MIFAREPLUS_API=',
            '-DLLA_CARDS_MIFAREULTRALIGHT_API=',
            '-DLLA_CARDS_PROX_API=',
            '-DLLA_CARDS_PROXLITE_API=',
            '-DLLA_CARDS_SAMAV2_API=',
            '-DLLA_CARDS_SEOS_API=',
            '-DLLA_CARDS_SMARTFRAME_API=',
            '-DLLA_CARDS_STMLRI_API=',
            '-DLLA_CARDS_TAGIT_API=',
            '-DLLA_CARDS_TOPAZ_API=',
            '-DLLA_CARDS_TWIC_API=',
            '-DLLA_CRYPTO_API=',
            '-DLLA_COMMON_API=',
            '-DLLA_READERS_A3MLGM5600_API=',
            '-DLLA_READERS_ADMITTO_API=',
            '-DLLA_READERS_A3MLGM5600_API=',
            '-DLLA_READERS_ADMITTO_API=',
            '-DLLA_READERS_A3MLGM5600_API=',
            '-DLLA_READERS_ADMITTO_API=',
            '-DLLA_READERS_AXESSTMC13_API=',
            '-DLLA_READERS_AXESSTMCLEGIC_API=',
            '-DLLA_READERS_DEISTER_API=',
            '-DLLA_READERS_ELATEC_API=',
            '-DLLA_READERS_GIGATMS_API=',
            '-DLLA_READERS_GUNNEBO_API=',
            '-DLLA_READERS_IDONDEMAND_API=',
            '-DLLA_READERS_ISO7816_API=',
            '-DLLA_READERS_PRIVATE_KEYBOARD_API=',
            '-DLLA_READERS_OK5553_API=',
            '-DLLA_READERS_OSDP_API=',
            '-DLLA_READERS_PCSC_API=',
            '-DLLA_READERS_PROMAG_API=',
            '-DLLA_READERS_RFIDEAS_API=',
            '-DLLA_READERS_RPLETH_API=',
            '-DLLA_READERS_SCIEL_API=',
            '-DLLA_READERS_SMARTID_API=',
            '-DLLA_READERS_STIDPRG_API=',
            '-DLLA_READERS_STIDSTR_API=',
            '-DLLA_CORE_API=',
            '-DLLA_CARDS_PRIVATE_DESFIRE2_API=',
            '-DLLA_CARDS_PRIVATE_ICLASS_API=',
            '-DLLA_CARDS_PRIVATE_ICLASS5321_API=',
            '-DLLA_CARDS_PRIVATE_ICLASS_API=',
            '-DLLA_CARDS_PRIVATE_ICLASS5321_API=',
            '-DLLA_READERS_PRIVATE_IDP_API=',
            '-DLLA_READERS_PRIVATE_ISO7816_API=',
            '-DLLA_READERS_PRIVATE_PCSC_API=',
            '-DLLA_READERS_NFC_NFC_API=']


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
        # and liblogicalaccess_crypto.i as they were manually generated ?
        if f.endswith('liblogicalaccess_card_sam.i'):  # or f.endswith('liblogicalaccess_crypto.i'):
            continue
        clean_swig_file(f)


def parse_translation_unit(filename):
    """
    Not really a Translation Unit, most likely an header file.
    :return: A TranslationUnit clang object.
    """
    index = clang.cindex.Index.create()
    options = clang.cindex.TranslationUnit.PARSE_SKIP_FUNCTION_BODIES | clang.cindex.TranslationUnit.PARSE_INCOMPLETE
    tu = index.parse(filename, ['-x', 'c++', '-std=c++14',
                                '-I../../installer/packages/include/'] + arglist_disable_export_macros(),
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
        if parent.kind == clang.cindex.CursorKind.NAMESPACE:
            namespaces = [parent.spelling] + namespaces
        parent = parent.semantic_parent
    return namespaces


def is_lla_namespace(node):
    namespaces = find_namespaces(node)
    return len(namespaces) and namespaces[0] == 'logicalaccess'


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
    types = set()
    for child_node in node.get_children():
        if child_node.kind == clang.cindex.CursorKind.CLASS_DECL or \
                child_node.kind == clang.cindex.CursorKind.STRUCT_DECL:

            if is_lla_namespace(child_node):
                full_namespaces = find_namespaces(child_node)
                fqn = '::'.join(full_namespaces) + '::' + child_node.spelling
                types.add(fqn)

                types |= find_template_parents(child_node)
        else:
            types |= gather_lla_types(child_node)
    return types


def gather_includes(filename, includes):
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
        includes.append(f)
        gather_includes('../../installer/packages/include/' + f, includes)

    return includes


def process_file(filename):
    logging.info('Processing {}'.format(filename))
    tu = parse_translation_unit(filename)
    return gather_lla_types(tu.cursor)


def process_file_includes(filename):
    return gather_includes(filename, [])


class SearchResult:
    def __init__(self):
        self.types = set()
        self.includes = set()
        self.imports = set()


def find_lla_infos(glob_string):
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
        search_result = SearchResult()
        ret = p.map(process_file_includes, files)
        for r in ret:
            for file in r:
                file_full = '../../installer/packages/include/' + file
                if file_full in files:
                    search_result.includes.add(file)
                else:
                    search_result.imports.add(file)

        ret = p.map(process_file, files)
        for r in ret:
            for type in r:
                search_result.types.add(type)
        return search_result


def write_for_module(module_name, search_result):
    filename = '../LibLogicalAccessNet.win32/liblogicalaccess_{}.i'.format(module_name)

    with open(filename, "r") as f:
        lines = f.readlines()
    i = 0
    while i < len(lines):
        if "/* Additional_include */\n" in lines[i]:
            i += 2
            for include in search_result.includes:
                include = include.replace('../../installer/packages/include/', '')
                lines.insert(i, "#include <{}>\n".format(include))
                i += 1
            lines.insert(i, "\n")
            i += 1
        if "/* Include_section */\n" in lines[i]:
            i += 2
            for include in search_result.includes:
                include = include.replace('../../installer/packages/include/', '')
                lines.insert(i, "%include <{}>\n".format(include))
                i += 1
            for import_ in search_result.imports:
                import_ = import_.replace('../../installer/packages/include/', '')
                lines.insert(i, "%import <{}>\n".format(import_))
                i += 1
            lines.insert(i, "\n")
            i += 1
        i += 1
    with open(filename, "w") as f:
        f.write(''.join(lines))


def write_shared_ptr(all_types):
    path = "../LibLogicalAccessNet.win32/liblogicalaccess.i"
    with open(path, "r") as f:
        lines = f.readlines()
        i = lines.index("/*****SHARED PTR SECTION*****/\n") + 1
        while i != lines.index("/*** MULTIPLE INHERITANCE ***/\n") - 1:
            del lines[i]
    i = lines.index("/*****SHARED PTR SECTION*****/\n") + 1
    lines.insert(i, "\n")
    i += 1

    for t in all_types:
        print('SPTR: {}'.format(t))
        lines.insert(i, "%shared_ptr(" + t.replace('logicalaccess::', '') + ");" + "\n")
        i += 1
    for t in all_types:
        lines.insert(i, "%shared_ptr(" + t + ");" + "\n")
        i += 1
    with open(path, "w") as f:
        f.write(''.join(lines))


def main():
    if os.name == 'posix':
        clang.cindex.Config.set_library_file('/usr/lib/llvm-6.0/lib/libclang.so')
    else:
        clang.cindex.Config.set_library_file('C:\\Program Files\\LLVM\\bin\\libclang.dll')

    x = find_lla_infos('test.cpp')
    print(x.types)
    return 0

    clean_files('../LibLogicalAccessNet.win32/')

    card_module_result = find_lla_infos("../../installer/packages/include/logicalaccess/plugins/cards/**/*.hpp")
    write_for_module('card', card_module_result)

    crypto_module_result = find_lla_infos("../../installer/packages/include/logicalaccess/plugins/crypto/**/*.hpp")
    write_for_module('crypto', crypto_module_result)

    reader_module_result = find_lla_infos("../../installer/packages/include/logicalaccess/plugins/readers/**/*.hpp")
    write_for_module('reader', reader_module_result)

    core_module_result = find_lla_infos(['../../installer/packages/include/logicalaccess/cards/**/*.hpp',
                                         '../../installer/packages/include/logicalaccess/services/**/*.hpp',
                                         '../../installer/packages/include/logicalaccess/readerproviders/**/*.hpp',
                                         '../../installer/packages/include/logicalaccess/*.hpp'])
    write_for_module('core', core_module_result)

    # Types
    all_types = card_module_result.types | reader_module_result.types | core_module_result.types
    write_shared_ptr(all_types)


if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)
    main()
