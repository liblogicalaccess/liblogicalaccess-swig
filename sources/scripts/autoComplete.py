#!/usr/bin/env python

import sys
import os
import glob
import re
import clang.cindex

baseinc = ["../../installer/packages/include/logicalaccess/plugins/cards/", "../../installer/packages/include/logicalaccess/plugins/readers/"]
regexsharedptr = r"(?<=std::shared_ptr<)(.*?)(?=>)"
regexns = r"(?<=\nnamespace )(.*?)(?=\n)"
regexinclude = r"(?<=#include [\"<])(.*?.hpp)(?=[\">]\n)"
includebase = "<logicalaccess{0}>"
include = []
nest = []
classlist = []
tmpinclude = []

def	parsesharedptr(content):
	ns = re.findall(regexns, content)
	matches = re.finditer(regexsharedptr, content)
	for match in matches:
		strmatch = str(match[0])
		nbr = strmatch.count('<')
		while nbr > 0:
			strmatch += str('>')
			nbr -= 1
		if "::" not in strmatch:
			strmatch = "::".join(ns) + "::" + strmatch
		if "std::" not in strmatch and strmatch not in classlist:
			classlist.append(strmatch)

def	innerincludeprocess(content, curpath, category):
	regex = re.findall(regexinclude, content)
	for inc in regex:
		inc = inc.lower().replace("\\", "/")
		incpath = "/".join(curpath.split("/")[:-1]) + "/" + inc
		if inc.split("/")[0] == "logicalaccess":
			if (inc.split("/")[1] == "plugins" and (category == "CARD" or category == "READER")) or (category == "CORE" and (inc.split("/")[1] == "cards" or inc.split("/")[1] == "readerproviders")):
				inc = "<" + inc + ">"
				tmp = curpath.split("logicalaccess")[0] + inc.replace(">", "").replace("<", "")
				if (category, inc, "include") not in include and (category, inc, "import") not in include and inc.split("/")[-1] not in tmpinclude:
					tmpinclude.append(inc.split("/")[-1])
					with open(tmp, "r") as f:
						content = f.read()
						innerincludeprocess(content, tmp, category)
						tmpinclude.pop()
					include.append((category, inc, "import"))
		elif os.path.isfile(incpath):
			inc = (os.path.normpath(incpath).split("logicalaccess")[-1]).replace("\\", "/")
			inc = (includebase.replace("{0}", inc))
			if (inc.split("/")[1] == "plugins" and (category == "CARD" or category == "READER")) or (category == "CORE" and (inc.split("/")[1] == "cards" or inc.split("/")[1] == "readerproviders")):
				tmp = curpath.split("logicalaccess")[0] + inc.replace(">", "").replace("<", "")
				if (category, inc, "include") not in include and (category, inc, "import") not in include and inc.split("/")[-1] not in tmpinclude:
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
					if (inc.split("/")[1] == "plugins" and (category == "CARD" or category == "READER")) or (category == "CORE" and (inc.split("/")[1] == "cards" or inc.split("/")[1] == "readerproviders")):
						tmp = curpath.split("logicalaccess")[0] + inc.replace(">", "").replace("<", "")
						if (category, inc, "include") not in include and (category, inc, "import") not in include and inc.split("/")[-1] not in tmpinclude:
							tmpinclude.append(inc.split("/")[-1])
							with open(tmp, "r") as f:
								content = f.read()
								innerincludeprocess(content, tmp, category)
								tmpinclude.pop()
							include.append((category, inc, "import"))
							break
			
def	includeprocess(path, category):
	if len(glob.glob(path, recursive=True)) == 0:
		print ("[ERROR]: nothing found in " + path)
	for filename in glob.glob(path, recursive=True):
		with open(filename, "r") as f:
			content = f.read()
			curpath = filename.replace("\\", "/")
			filename = filename.replace("\\", "/").split("logicalaccess")[-1]
			innerincludeprocess(content, curpath, category)
			inc = includebase.replace("{0}", filename).lower()
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

def	lookdata(curcat):
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
			continue #unknown template type
		
		#if c.kind == clang.cindex.CursorKind.STRUCT_DECL and c.spelling != None and c.location.file.name == filename:
		#	if c.spelling not in classlist:
		#		classlist.append(c.spelling)
		#	print(c.spelling)
		#	print(c.location.file.name)
		
		if c.kind == clang.cindex.CursorKind.CLASS_DECL and c.location.file.name == filename:
			if len(nest) == 0:
				if c.spelling not in classlist:
					classlist.append(c.spelling)
			else:
				if "::".join(nest) + "::" + c.spelling not in classlist:
					classlist.append("::".join(nest) + "::" + c.spelling)
					nest.append(c.spelling)
			find_classdecl(c, filename)		
		elif c.kind == clang.cindex.CursorKind.NAMESPACE and c.location.file.name == filename:
			nest.append(c.spelling)
			find_classdecl(c, filename)
		if len(nest) > 0 and nest[-1] == c.spelling:
			nest.pop()
	
def	sharedptrprocess():
	clang.cindex.Config.set_library_file('C:/Program Files/LLVM/bin/libclang.dll')
	index = clang.cindex.Index.create()
	options = clang.cindex.TranslationUnit.PARSE_SKIP_FUNCTION_BODIES | clang.cindex.TranslationUnit.PARSE_INCOMPLETE
	for filename in glob.glob("../../installer/packages/include/logicalaccess/**/*.hpp", recursive=True):
		tu = index.parse(filename, ['-x', 'c++', '-std=c++11', '-DLIBLOGICALACCESS_API='], unsaved_files=None, options=options)
		find_classdecl(tu.cursor, filename)
	classlist.sort()
	
def	sharedptrwrite():
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
	sharedptrwrite()
	includewrite()

main()
