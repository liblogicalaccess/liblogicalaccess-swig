#!/usr/bin/python

import re
import os

exceptionPath = "../LibLogicalAccessNet/Exception"
regex = r"(?<=\s:\s)(.*System.IDisposable)(?=\s{)"
regexwhat = r"(public string)(?=\swhat\(\)\s{)"


def main():
    for filename in os.listdir(exceptionPath):
        if filename.endswith(".cs"):
            filepath = exceptionPath + "/" + filename
            print('Editing file {}'.format(filepath))
            with open(filepath, "r", encoding="utf-8") as f:
                content = f.read()
                content = re.sub(regex, "CustomException", content)
                content = re.sub(regexwhat, "public override string", content)
                f.flush()
                f.close()
            with open(filepath, "w", encoding="utf-8") as f:
                f.write(content)
                f.flush()
                f.close()


if __name__ == "__main__":
    main()
