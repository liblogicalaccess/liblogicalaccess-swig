import sys
import os
import glob
import re

regexsharedptr = r"(?<=std::shared_ptr<)(.*?)(?=>)"
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

def cleandoc(path):
	with open(path, "r") as f:
		lines = f.readlines()
		a = lines.index("/* Additional_include */\n") + 1
		while a != lines.index("/* END_Additional_include */\n") - 1:
			del lines[a]
		a = lines.index("/* Shared_ptr */\n") + 1
		while a != lines.index("/* END_Shared_ptr */\n") - 1:
			del lines[a]
		a = lines.index("/* Include_section */\n") + 1
		while a != lines.index("/* END_Include_section */\n") - 1:
			del lines[a]
	return lines

def	lookdata(curcat):
	retinclude = []
	retsptr = []
	for cat, inc in include:
		if curcat == cat:
			retinclude.append(inc)
	for cat, sptr in shared_ptr:
		if curcat == cat:
			retsptr.append(sptr)
	return retsptr, retinclude
	
def docprocess():
	path = "../liblogicalaccess-swig.win32/liblogicalaccess{0}.i"
	
	cardpath = path.replace("{0}", "_card")
	cardsptr, cardinc = lookdata("CARD")
	lines = cleandoc(cardpath)
	i = 0
	prevtype = ""
	curtype = ""
	while i < len(lines):
		if "/* Additional_include */\n" in lines[i]:
			i += 2
			for cinc in cardinc:			
				if len(cinc.split("plugins/cards/")[-1].split("/")) == 1:
					curtype = ""
				else:
					curtype = cinc.split("plugins/cards/")[-1].split("/")[0]
				if curtype != prevtype:
					lines.insert(i, "\n")
					i += 1
				prevtype = curtype
				lines.insert(i, "#include {0}\n".format(cinc))
				i += 1
			lines.insert(i, "\n")
			i += 1
		if "/* Shared_ptr */\n" in lines[i]:
			i += 2
			for cc in cardsptr:
				lines.insert(i, "%shared_ptr(" + cc + ");" + "\n")
				i += 1
			lines.insert(i, "\n")
			i += 1
		if "/* Include_section */\n" in lines[i]:
			i += 2
			for cinc in cardinc:			
				if len(cinc.split("plugins/cards/")[-1].split("/")) == 1:
					curtype = ""
				else:
					curtype = cinc.split("plugins/cards/")[-1].split("/")[0]
				if curtype != prevtype:
					lines.insert(i, "\n")
					i += 1
				prevtype = curtype
				lines.insert(i, "%include {0}\n".format(cinc))
				i += 1
			lines.insert(i, "\n")
			i += 1
		i += 1	
	with open(cardpath, "w") as f:
		f.write(''.join(lines))
	
	readerpath = path.replace("{0}", "_reader")
	readersptr, readerinc = lookdata("READER")
	lines = cleandoc(readerpath)
	i = 0
	prevtype = ""
	curtype = ""
	while i < len(lines):
		if "/* Additional_include */\n" in lines[i]:
			i += 2
			for rinc in readerinc:
				if "/readerproviders/" in rinc:
					curtype = ""
				else:
					curtype = rinc.split("plugins/readers/")[-1].split("/")[0]
				if curtype != prevtype:
					lines.insert(i, "\n")
					i += 1
				prevtype = curtype
				lines.insert(i, "#include {0}\n".format(rinc))
				i += 1
			lines.insert(i, "\n")
			i += 1
		if "/* Shared_ptr */\n" in lines[i]:
			i += 2
			for rc in readersptr:
				lines.insert(i, "%shared_ptr(" + rc + ");" + "\n")
				i += 1
			lines.insert(i, "\n")
			i += 1
		if "/* Include_section */\n" in lines[i]:
			i += 2
			for rinc in readerinc:
				if "/readerproviders/" in rinc:
					curtype = ""
				else:
					curtype = rinc.split("plugins/readers/")[-1].split("/")[0]
				if curtype != prevtype:
					lines.insert(i, "\n")
					i += 1
				prevtype = curtype
				lines.insert(i, "%include {0}\n".format(rinc))
				i += 1
			lines.insert(i, "\n")
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