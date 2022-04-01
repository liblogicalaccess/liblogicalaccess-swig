Param(
    [Parameter(Mandatory)]
    [string]$arch,
    [Parameter(Mandatory)]
    [string]$build_type,
    [Parameter(Mandatory=$false)]
    [bool]$build_private,
    [Parameter(Mandatory=$false)]
    [bool]$build_nfc,
    [Parameter(Mandatory=$false)]
    [bool]$build_rfideas
)

Write-Host $arch $build_type $build_private $build_nfc
Set-Location installer
.\conan-imports.ps1 -arch $arch -build_type $build_type -build_private $build_private -build_nfc $build_nfc -build_rfideas $build_rfideas
Set-Location ../sources/scripts
pip install -r requirements.txt
Set-Location ../../
.\sources/scripts/update-gitversion-vs2017proj.ps1 sources/LibLogicalAccessNet/LibLogicalAccessNet.csproj
.\sources/scripts/generate-swig.ps1
Set-Location sources/LibLogicalAccessNet.win32
./conan-build.ps1 -arch $arch -build_type $build_type -build_private $build_private -build_nfc $build_nfc -build_rfideas $build_rfideas

Set-Location ..

msbuild -t:restore
if ($build_private) {
    msbuild LibLogicalAccessNet.sln /p:Configuration="Release"
} else {
    msbuild LibLogicalAccessNet.sln /p:Configuration="ReleaseCE"
}

Set-Location ..