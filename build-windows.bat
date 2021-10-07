set /p isCE=Do you want to build the community edition (y/n)?
set cmdCE=
if "%isCE%"=="y" (
  set cmdCE=-ce
)

cd installer
call conan-imports.bat %isCE%
cd ../sources/scripts
pip install -r requirements.txt
cd ../../
powershell -File sources/scripts/update-gitversion-vs2017proj.ps1 sources/LibLogicalAccessNet/LibLogicalAccessNet.csproj
powershell -File sources/scripts/generate-swig.ps1
cd sources/LibLogicalAccessNet.win32
powershell -File ./conan-build.ps1 %cmdCE%

cd ../
if "%isCE%"=="y" (
	msbuild LibLogicalAccessNet.sln /p:Configuration="ReleaseCE"
) else (
	msbuild LibLogicalAccessNet.sln /p:Configuration="Release"
)
cd ../