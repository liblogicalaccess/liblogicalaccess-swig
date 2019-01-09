cd sources/scripts
Write-Host "Build swig interface..."
& python.exe .\autoComplete.py
Write-Host "Build swig interface done. Calling SWIG..."
& .\swig-build.ps1
Write-Host "SWIG done. Adapt Exception class..."
& python.exe .\adaptExceptionClass.py
Write-Host "Adapt Exception class done."
cd ../..
