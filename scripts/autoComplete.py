import sys
import os
import glob
import re

regexsharedptr = r"(?<=std::shared_ptr<)(.*?)(?=>)"
regextemplate = r"(([a-zA-Z0-9]*::)+)*[a-zA-Z]*<.*?>"
includebase = "<logicalaccess{0}>"
include = []
shared_ptr = []

def	parsesharedptr(category, content):
	matches = re.finditer(regexsharedptr, content)
	for match in matches:
		strmatch = str(match[0])
		nbr = strmatch.count('<')
		while nbr > 0:
			strmatch += str('>')
			nbr -= 1
		strmatch = "logicalaccess::" + strmatch
		if not (category, strmatch) in shared_ptr:
			shared_ptr.append((category, strmatch))
	

def	processing(path, category):
	if len(glob.glob(path, recursive=True)) == 0:
		print ("[ERROR]: nothing found in " + path)
	for filename in glob.glob(path, recursive=True):
		with open(filename, "r") as f:
			content = f.read()
			parsesharedptr(category,content)
			filename = filename.replace("\\", "/").split("logicalaccess")[-1]
			include.append((category, includebase.replace("{0}", filename)))

def	lookdata(curcat, path):
	with open(path, "r") as f:
		lines = f.readlines()
		# Shared_ptr
		a = lines.index("/* Shared_ptr */\n")
		c = a + 1
		while lines[c] is "\n":
			c += 1
		i = 0
		datas = lines[c:]
		while "/* END_Shared_ptr */" not in datas[i]:
			i += 1
		datas = datas[:i]
		# Includes
		a = lines.index("/* Additional_include */\n")
		c = a + 1
		while lines[c] is "\n":
			c += 1
		i = 0
		includes = lines[c:]
		while "/* END_Additional_include */\n" not in includes[i]:
			i += 1
		includes = includes[:i]
	for category, ptr in shared_ptr:
		for data in datas:
			if ptr in data:
				break
		if datas.index(data) is len(datas) - 1:
			datas.append("%shared_ptr({0});\n".format(ptr));
	for category, ptr in include:
		for inc in includes:
			if ptr in inc:
				break
		if includes.index(inc) is len(includes) - 1:
			includes.append(ptr);
	for el in datas:
		print (el, end='')
	return (datas, includes)

def cleandoc(path):
	with open(path, "r") as f:
		lines = f.readlines()
		a = lines.index("/* Shared_ptr */\n") + 1
		while a != lines.index("/* END_Shared_ptr */\n") - 1:
			del lines[a]
		a = lines.index("/* Additional_include */\n") + 1
		while a != lines.index("/* END_Additional_include */\n") - 1:
			del lines[a]
		a = lines.index("/* Include_section */\n") + 1
		while a != lines.index("/* END_Include_section */\n") - 1:
			del lines[a]
	return lines


def docprocess():
	path = "../liblogicalaccess-swig.win32/liblogicalaccess{0}.i"
	
	cardpath = path.replace("{0}", "_card")
	cards, cardinc = lookdata("CARD", cardpath)
	lines = cleandoc(cardpath)
	i = 0
	while i < len(lines):
		if "/* Shared_ptr */\n" in lines[i]:
			i += 2
			for cc in cards:
				lines.insert(i, cc)
				i += 1
		if "/* Additional_include */\n" in lines[i]:
			i += 2
			for cinc in cardinc:
				lines.insert(i, "{0}".format(cinc))
				i += 1
		if "/* Include_section */\n" in lines[i]:
			i += 2
			for cinc in cardinc:
				lines.insert(i, "{0}".format(cinc.replace("#", "%")))
				i += 1
		i += 1	
	with open(cardpath, "w") as f:
		f.write(''.join(lines))
	readerpath = path.replace("{0}", "_reader")
	readers, readerinc = lookdata("READER", readerpath)
	lines = cleandoc(readerpath)
	i = 0
	while i < len(lines):
		if "/* Shared_ptr */\n" in lines[i]:
			i += 2
			for rd in readers:
				lines.insert(i, rd)
				i += 1
		if "/* Additional_include */\n" in lines[i]:
			i += 2
			for rinc in readerinc:
				lines.insert(i, "{0}".format(rinc))
				i += 1
		if "/* Include_section */\n" in lines[i]:
			i += 2
			for rinc in readerinc:
				lines.insert(i, "{0}".format(rinc.replace("#", "%")))
				i += 1
		i += 1	
	with open(readerpath, "w") as f:
		f.write(''.join(lines))
				
def main():
	processing("../packages/include/logicalaccess/cards/**/*.hpp", "CARD")
	processing("../packages/include/logicalaccess/plugins/cards/**/*.hpp", "CARD")
	processing("../packages/include/logicalaccess/readerproviders/**/*.hpp", "READER")
	processing("../packages/include/logicalaccess/plugins/readers/**/*.hpp", "READER")
	docprocess()
main()