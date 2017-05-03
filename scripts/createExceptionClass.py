#!/usr/bin/python

import sys
import os
import filecmp
#import xml.etree.ElementTree as ET
#import xml.dom.minidom as MD
from lxml import etree, objectify

if (len(sys.argv) < 2):
	print("Missing argument to script. End of script.", file=sys.stderr)
	exit (-1)

try:
	if (len(sys.argv) == 3):
		namespace = sys.argv[2];
	else:
		namespace = "swig";

	curLoc = os.path.dirname(os.path.realpath(__file__))
	exceptPath = curLoc + "/../LibLogicalAccessNet/Exception/"
	if not (os.path.exists(exceptPath)):
		os.makedirs(exceptPath)

	tmpException = "tmp" + sys.argv[1] + ".cs"
	tmpFile = open(tmpException, "a+")
	csharpException = "using System;\n\nnamespace " + namespace + "\n{\nclass " + sys.argv[1] + " : CustomException\n{\n        public " + sys.argv[1] + "()\n        {\n        }\n\n        public "+ sys.argv[1] + "(string message)\n            : base(message)\n        {\n        }\n\n        public " + sys.argv[1] + "(string message, Exception inner)\n            : base(message, inner)\n        {\n        }\n    }\n}"
	tmpFile.write(csharpException)
	tmpFile.close()
	
	if (os.path.exists(exceptPath + sys.argv[1] + ".cs")):
		if (filecmp.cmp(exceptPath + sys.argv[1] + ".cs", tmpException)):
			os.remove(tmpException)
		else:
			os.remove(exceptPath + sys.argv[1] + ".cs")
	if (os.path.exists(tmpException)):
		os.rename(tmpException, exceptPath + sys.argv[1] + ".cs")
	
except Exception as e:
		print("Error: {0}. End of script.").format(str(e))
		exit (-1)
