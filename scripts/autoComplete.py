import sys
import os
import glob
import re

regexsharedptr = r"(?<=std::shared_ptr<)(.*?)(?=>)"
includebase = "<logicalaccess{0}>"
include = []
shared_ptr = []

def	parsesharedptr(content):
	matches = re.finditer(regexsharedptr, content)
	for match in matches:
		strmatch = str(match[0])
		nbr = strmatch.count('<')
		while nbr > 0:
			strmatch += str('>')
			nbr -= 1
		if not strmatch.startswith("logicalaccess::") and not strmatch.startswith("openssl::") and not strmatch.startswith("boost::") and not strmatch.startswith("std::"):
			strmatch = "logicalaccess::" + strmatch
		if "std::" not in strmatch and strmatch not in shared_ptr:
			shared_ptr.append(strmatch)
	shared_ptr.sort()

def	sharedptrprocess(path):
	if len(glob.glob(path, recursive=True)) == 0:
		print ("[ERROR]: nothing found in " + path)
	for filename in glob.glob(path, recursive=True):
		with open(filename, "r") as f:
			content = f.read()
			parsesharedptr(content)
	
def	includeprocess(path, category):
	if len(glob.glob(path, recursive=True)) == 0:
		print ("[ERROR]: nothing found in " + path)
	for filename in glob.glob(path, recursive=True):
		with open(filename, "r") as f:
			content = f.read()
			filename = filename.replace("\\", "/").split("logicalaccess")[-1]
			include.append((category, includebase.replace("{0}", filename)))

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
	for cat, inc in include:
		if curcat == cat:
			retinclude.append(inc)
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
			for cinc in cardinc:			
				lines.insert(i, "#include {0}\n".format(cinc))
				i += 1
			lines.insert(i, "\n")
			i += 1
		if "/* Include_section */\n" in lines[i]:
			i += 2
			for cinc in cardinc:			
				lines.insert(i, "%include {0}\n".format(cinc))
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
			for cinc in cardinc:
				lines.insert(i, "#include {0}\n".format(cinc))
				i += 1
			lines.insert(i, "\n")
			i += 1
		if "/* Include_section */\n" in lines[i]:
			i += 2
			for cinc in cardinc:
				lines.insert(i, "%include {0}\n".format(cinc))
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
			for rinc in readerinc:
				lines.insert(i, "#include {0}\n".format(rinc))
				i += 1
			lines.insert(i, "\n")
			i += 1
		if "/* Include_section */\n" in lines[i]:
			i += 2
			for rinc in readerinc:
				lines.insert(i, "%include {0}\n".format(rinc))
				i += 1
			lines.insert(i, "\n")
			i += 1
		i += 1	
	with open(readerpath, "w") as f:
		f.write(''.join(lines))
	
def	sharedptrwrite():
	path = "../LibLogicalAccessNet.win32/liblogicalaccess.i"
	with open(path, "r") as f:
		lines = f.readlines()
		i = lines.index("/*****SHARED PTR SECTION*****/\n") + 1
		while i != lines.index("/*****POST PROCESSING INSTRUCTIONS*****/\n") - 1:
			del lines[i]
	i = lines.index("/*****SHARED PTR SECTION*****/\n") + 1
	lines.insert(i, "\n")
	i += 1
	for sptr in shared_ptr:
		lines.insert(i, "%shared_ptr(" + sptr + ");" + "\n")
		i += 1
	with open(path, "w") as f:
		f.write(''.join(lines))
		
def main():
	sharedptrprocess("../packages/include/logicalaccess/**/*.hpp")
	includeprocess("../packages/include/logicalaccess/cards/**/*.hpp", "CORE")
	includeprocess("../packages/include/logicalaccess/plugins/cards/**/*.hpp", "CARD")
	includeprocess("../packages/include/logicalaccess/readerproviders/**/*.hpp", "CORE")
	includeprocess("../packages/include/logicalaccess/plugins/readers/**/*.hpp", "READER")
	sharedptrwrite()
	includewrite()
main()
