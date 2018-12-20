#!/usr/bin/env python

import sys
import os
import glob
import re
import clang.cindex
from multiprocessing.pool import ThreadPool

baseinc = ["../../installer/packages/include/logicalaccess/plugins/cards/",
           "../../installer/packages/include/logicalaccess/plugins/readers/"]
regexsharedptr = r"(?<=std::shared_ptr<)(.*?)(?=>)"
regexns = r"(?<=\nnamespace )(.*?)(?=\n)"
regexinclude = r"(?<=#include [\"<])(.*?.hpp)(?=[\">]\n)"
includebase = "<logicalaccess{0}>"
include = []
nest = []
classlist = []
tmpinclude = []


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


def parsesharedptr(content):
    ns = re.findall(regexns, content)
    matches = re.finditer(regexsharedptr, content)
    for match in matches:
        strmatch = str(match.group(0))
        nbr = strmatch.count('<')
        while nbr > 0:
            strmatch += str('>')
            nbr -= 1
        if "::" not in strmatch:
            strmatch = "::".join(ns) + "::" + strmatch
        if "std::" not in strmatch and strmatch not in classlist:
            print("Add from parsesharedptr: {}".format(strmatch))
            classlist.append(strmatch)


def innerincludeprocess(content, curpath, category):
    regex = re.findall(regexinclude, content)
    for inc in regex:
        inc = inc.replace("\\", "/")
        incpath = "/".join(curpath.split("/")[:-1]) + "/" + inc
        if inc.split("/")[0] == "logicalaccess":
            if (inc.split("/")[1] == "plugins" and (category == "CARD" or category == "READER")) or (
                    category == "CORE" and (inc.split("/")[1] == "cards" or inc.split("/")[1] == "readerproviders")):
                inc = "<" + inc + ">"
                tmp = curpath.split("logicalaccess")[0] + inc.replace(">", "").replace("<", "")
                if (category, inc, "include") not in include and (category, inc, "import") not in include and \
                        inc.split("/")[-1] not in tmpinclude:
                    tmpinclude.append(inc.split("/")[-1])
                    with open(tmp, "r") as f:
                        content = f.read()
                        innerincludeprocess(content, tmp, category)
                        tmpinclude.pop()
                    include.append((category, inc, "import"))
        elif os.path.isfile(incpath):
            inc = (os.path.normpath(incpath).split("logicalaccess")[-1]).replace("\\", "/")
            inc = (includebase.replace("{0}", inc))
            if (inc.split("/")[1] == "plugins" and (category == "CARD" or category == "READER")) or (
                    category == "CORE" and (inc.split("/")[1] == "cards" or inc.split("/")[1] == "readerproviders")):
                tmp = curpath.split("logicalaccess")[0] + inc.replace(">", "").replace("<", "")
                if (category, inc, "include") not in include and (category, inc, "import") not in include and \
                        inc.split("/")[-1] not in tmpinclude:
                    tmpinclude.append(inc.split("/")[-1])
                    with open(tmp, "r") as f:
                        content = f.read()
                        innerincludeprocess(content, tmp, category)
                        tmpinclude.pop()
                    include.append((category, inc, "import"))
        else:
            for el in baseinc:
                if os.path.isfile(el + inc):
                    inc = (os.path.normpath(el + inc).split("logicalaccess")[-1]).replace("\\", "/")
                    inc = (includebase.replace("{0}", inc))
                    if (inc.split("/")[1] == "plugins" and (category == "CARD" or category == "READER")) or (
                            category == "CORE" and (
                            inc.split("/")[1] == "cards" or inc.split("/")[1] == "readerproviders")):
                        tmp = curpath.split("logicalaccess")[0] + inc.replace(">", "").replace("<", "")
                        if (category, inc, "include") not in include and (category, inc, "import") not in include and \
                                inc.split("/")[-1] not in tmpinclude:
                            tmpinclude.append(inc.split("/")[-1])
                            with open(tmp, "r") as f:
                                content = f.read()
                                innerincludeprocess(content, tmp, category)
                                tmpinclude.pop()
                            include.append((category, inc, "import"))
                            break


def includeprocess(path, category):
    if len(glob.glob(path, recursive=True)) == 0:
        print("[ERROR]: nothing found in " + path)
    for filename in glob.glob(path, recursive=True):
        print('Will read file {}'.format(filename))
        with open(filename, "r", encoding='utf-8') as f:
            content = f.read()
            curpath = filename.replace("\\", "/")
            filename = filename.replace("\\", "/").split("logicalaccess")[-1]
            innerincludeprocess(content, curpath, category)
            inc = includebase.replace("{0}", filename)
            if (category, inc, "include") not in include and (category, inc, "import") not in include:
                include.append((category, inc, "include"))
            elif (category, inc, "import") in include:
                include[include.index((category, inc, "import"))] = (category, inc, "include")
            parsesharedptr(content)


def cleandoc(path):
    with open(path, "r") as f:
        lines = f.readlines()
        a = lines.index("/* Additional_include */\n") + 1
        while a != lines.index("/* END_Additional_include */\n") - 1:
            del lines[a]
        a = lines.index("/* Include_section */\n") + 1
        while a != lines.index("/* END_Include_section */\n") - 1:
            del lines[a]
    return lines


def lookdata(curcat):
    retinclude = []
    for cat, inc, type in include:
        if curcat == cat:
            retinclude.append((inc, type))
    return retinclude


def includewrite():
    path = "../LibLogicalAccessNet.win32/liblogicalaccess{0}.i"

    cardpath = path.replace("{0}", "_core")
    cardinc = lookdata("CORE")
    lines = cleandoc(cardpath)
    i = 0
    while i < len(lines):
        if "/* Additional_include */\n" in lines[i]:
            i += 2
            for cinc, type in cardinc:
                lines.insert(i, "#include {0}\n".format(cinc))
                i += 1
            lines.insert(i, "\n")
            i += 1
        if "/* Include_section */\n" in lines[i]:
            i += 2
            for cinc, type in cardinc:
                lines.insert(i, "%{0} {1}\n".format(type, cinc))
                i += 1
            lines.insert(i, "\n")
            i += 1
        i += 1
    with open(cardpath, "w") as f:
        f.write(''.join(lines))

    cardpath = path.replace("{0}", "_card")
    cardinc = lookdata("CARD")
    lines = cleandoc(cardpath)
    i = 0
    while i < len(lines):
        if "/* Additional_include */\n" in lines[i]:
            i += 2
            for cinc, type in cardinc:
                lines.insert(i, "#include {0}\n".format(cinc))
                i += 1
            lines.insert(i, "\n")
            i += 1
        if "/* Include_section */\n" in lines[i]:
            i += 2
            for cinc, type in cardinc:
                lines.insert(i, "%{0} {1}\n".format(type, cinc))
                i += 1
            lines.insert(i, "\n")
            i += 1
        i += 1
    with open(cardpath, "w") as f:
        f.write(''.join(lines))

    readerpath = path.replace("{0}", "_reader")
    readerinc = lookdata("READER")
    lines = cleandoc(readerpath)
    i = 0
    while i < len(lines):
        if "/* Additional_include */\n" in lines[i]:
            i += 2
            for rinc, type in readerinc:
                lines.insert(i, "#include {0}\n".format(rinc))
                i += 1
            lines.insert(i, "\n")
            i += 1
        if "/* Include_section */\n" in lines[i]:
            i += 2
            for rinc, type in readerinc:
                lines.insert(i, "%{0} {1}\n".format(type, rinc))
                i += 1
            lines.insert(i, "\n")
            i += 1
        i += 1
    with open(readerpath, "w") as f:
        f.write(''.join(lines))


def find_classdecl(node, filename):
    global curnamespace
    for c in node.get_children():
        try:
            c.kind
        except ValueError as e:
            print(e)
            continue  # unknown template type

        # if c.kind == clang.cindex.CursorKind.STRUCT_DECL and c.spelling != None and c.location.file.name == filename:
        #	if c.spelling not in classlist:
        #		classlist.append(c.spelling)
        #	print(c.spelling)
        #	print(c.location.file.name)

        if c.kind == clang.cindex.CursorKind.CLASS_DECL and c.location.file.name == filename:
            if len(nest) == 0:
                if c.spelling not in classlist:
                    print("Add SPELLING {}. Filename: {}".format(c.spelling, filename))
                    classlist.append(c.spelling)
            else:
                if "::".join(nest) + "::" + c.spelling not in classlist:
                    print("Add OTHER {}. Filename: {}".format("::".join(nest) + "::" + c.spelling, filename))
                    classlist.append("::".join(nest) + "::" + c.spelling)
                    nest.append(c.spelling)
            find_classdecl(c, filename)
        elif c.kind == clang.cindex.CursorKind.NAMESPACE and c.location.file.name == filename:
            print("Add namespace: {}".format(c.spelling))
            nest.append(c.spelling)
            find_classdecl(c, filename)
        if len(nest) > 0 and nest[-1] == c.spelling:
            nest.pop()


def find_lla_classes(node, namespace):
    classes = []
    for c in node.get_children():
        if c.kind == clang.cindex.CursorKind.NAMESPACE:
            classes += find_lla_classes(c, namespace + [c.spelling])
        elif c.kind == clang.cindex.CursorKind.CLASS_DECL:
            fqn = "::".join(namespace) + '::' + c.spelling
            classes.append(fqn)
    return classes


def do_clang_parse(filename):
    index = clang.cindex.Index.create()
    options = clang.cindex.TranslationUnit.PARSE_SKIP_FUNCTION_BODIES | clang.cindex.TranslationUnit.PARSE_INCOMPLETE
    tu = index.parse(filename, ['-x', 'c++', '-std=c++14',
                                '-I../../installer/packages/include/'] + arglist_disable_export_macros(),
                     unsaved_files=None, options=options)
    return tu


def sharedptrprocess():
    if os.name == 'posix':
        clang.cindex.Config.set_library_file('/usr/lib/llvm-6.0/lib/libclang.so')
    else:
        clang.cindex.Config.set_library_file('C:\\Program Files\\LLVM\\bin\\libclang.dll')

    pool = ThreadPool(processes=6)
    files = glob.glob("../../installer/packages/include/logicalaccess/**/*.hpp", recursive=True)
    i = 0
    while i < len(files):
        # We run the clang parser in parallel, 6 files by 6 files.
        async_results = []

        left = len(files) - i
        c = 0
        while c < left and c < 6:
            async_results.append((pool.apply_async(do_clang_parse, [files[i + c]]), files[i + c]))
            c += 1

        translation_units = []
        for a, b in async_results:
            translation_units.append((a.get(), b))

        for t, filename in translation_units:
            find_classdecl(t.cursor, filename)
        i += c
    classlist.sort()


def sharedptrwrite():
    path = "../LibLogicalAccessNet.win32/liblogicalaccess.i"
    with open(path, "r") as f:
        lines = f.readlines()
        i = lines.index("/*****SHARED PTR SECTION*****/\n") + 1
        while i != lines.index("/*** MULTIPLE INHERITANCE ***/\n") - 1:
            del lines[i]
    i = lines.index("/*****SHARED PTR SECTION*****/\n") + 1
    lines.insert(i, "\n")
    i += 1
    for sptr in classlist:
        print("Would add {}".format(sptr))

    for sptr in classlist:
        lines.insert(i, "%shared_ptr(" + sptr + ");" + "\n")
        i += 1
    for sptr in classlist:
        lines.insert(i, "%shared_ptr(" + sptr.split("::")[-1] + ");" + "\n")
        i += 1
    with open(path, "w") as f:
        f.write(''.join(lines))


def main():
    print("Processing includes...")
    includeprocess("../../installer/packages/include/logicalaccess/cards/**/*.hpp", "CORE")
    includeprocess("../../installer/packages/include/logicalaccess/services/**/*.hpp", "CORE")
    includeprocess("../../installer/packages/include/logicalaccess/plugins/cards/**/*.hpp", "CARD")
    includeprocess("../../installer/packages/include/logicalaccess/readerproviders/**/*.hpp", "CORE")
    includeprocess("../../installer/packages/include/logicalaccess/plugins/readers/**/*.hpp", "READER")
    print("Processing shared_ptr...")
    sharedptrprocess()
    print("Write shared ptr")
    sharedptrwrite()
    print("Write include")
    includewrite()


main()
