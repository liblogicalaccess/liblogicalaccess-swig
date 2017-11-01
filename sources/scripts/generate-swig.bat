cd sources/scripts
call autoCompleteScript.bat
Powershell.exe -executionpolicy remotesigned -File swig-build.ps1
call adaptExceptionScript.bat
cd ../..