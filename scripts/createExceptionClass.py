#!/usr/bin/python

import sys
import os
import filecmp
import clang.cindex

filelist = [ "../packages/include/logicalaccess/myexception.hpp", "../packages/include/logicalaccess/crypto/openssl_exception.hpp"]

def createexception(classname):
	curLoc = os.path.dirname(os.path.realpath(__file__))
	exceptPath = curLoc + "/../LibLogicalAccessNet/Exception/"
	if not (os.path.exists(exceptPath)):
		os.makedirs(exceptPath)
	tmpException = "tmp" + classname + ".cs"
	tmpFile = open(tmpException, "a+")
	csharpException = "using System;\n\nnamespace LibLogicalAccess.Exception\n{\n\tclass " + classname + " : CustomException\n\t{\n\t\tpublic " + classname + "()\n\t\t{ }\n\n\t\tpublic "+ classname + "(string message)\n\t\t\t: base(message)\n\t\t{ }\n\n\t\tpublic " + classname + "(string message, Exception inner)\n\t\t\t: base(message, inner)\n\t\t{ }\n\t}\n}"
	tmpFile.write(csharpException)
	tmpFile.close()
	if (os.path.exists(exceptPath + classname + ".cs")):
		if (filecmp.cmp(exceptPath + classname + ".cs", tmpException)):
			os.remove(tmpException)
		else:
			os.remove(exceptPath + classname + ".cs")
	if (os.path.exists(tmpException)):
		os.rename(tmpException, exceptPath + classname + ".cs")
	
def lookforexceptionclass(node, filename):
	for c in node.get_children():
		if c.location.file.name == filename:
			if c.kind == clang.cindex.CursorKind.CLASS_DECL and c.location.file.name == filename:
				print(c.spelling)
				createexception(c.spelling)
			lookforexceptionclass(c, filename)
    
def main():
	clang.cindex.Config.set_library_file('C:/Program Files/LLVM/bin/libclang.dll')
	index = clang.cindex.Index.create()
	options = clang.cindex.TranslationUnit.PARSE_SKIP_FUNCTION_BODIES | clang.cindex.TranslationUnit.PARSE_INCOMPLETE
	tu = index.parse(filelist[0], ['-x', 'c++', '-std=c++11', '-DLIBLOGICALACCESS_API='], unsaved_files=None, options=options)
	lookforexceptionclass(tu.cursor, filelist[0])
	tu = index.parse(filelist[1], ['-x', 'c++', '-std=c++11', '-DLIBLOGICALACCESS_API='], unsaved_files=None, options=options)
	lookforexceptionclass(tu.cursor, filelist[1])
  
main()