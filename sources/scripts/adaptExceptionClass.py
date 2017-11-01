#!/usr/bin/python

import re
import os

exceptionPath = "../LibLogicalAccessNet/Exception"
regex = r"(?<=\s:\s)(.*System.IDisposable)(?=\s{)"
regexwhat = r"(public string)(?=\swhat\(\)\s{)"

def main():
	for filename in os.listdir(exceptionPath):
		if filename.endswith(".cs"):
			with open(exceptionPath + "/" + filename, "r") as f:
				content = f.read()
				content = re.sub(regex, "CustomException", content)
				content = re.sub(regexwhat, "public override string", content)
				f.flush()
				f.close()
			with open(exceptionPath + "/" + filename, "w") as f:
				f.write(content)
				f.flush()
				f.close()
				
main()