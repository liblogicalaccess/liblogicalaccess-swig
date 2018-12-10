cd sources/scripts
& python.exe .\autoComplete.py
& .\swig-build.ps1
& python.exe .\adaptExceptionClass.py
cd ../..
