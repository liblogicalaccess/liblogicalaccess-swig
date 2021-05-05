set /p isCE=Do you want to build the community edition (y/n)?

cd installer
conan-imports.bat %isCE%
cd sources/scripts
pip install -r requirements.txt
cd ../../
powershell -File sources/scripts/update-gitversion-vs2017proj.ps1 sources/LibLogicalAccessNet/LibLogicalAccessNet.csproj
powershell -File sources/scripts/generate-swig.ps1
cd sources/LibLogicalAccessNet.win32
powershell -File ./conan-build.ps1 '-ce %isCE%'