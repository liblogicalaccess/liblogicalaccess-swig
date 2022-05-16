Param(
    [Parameter(ParameterSetName="WithProfile", Mandatory)]
    [switch]$with_profile,
    [Parameter(ParameterSetName="WithoutProfile", Mandatory)]
    [string]$arch,
    [Parameter(ParameterSetName="WithoutProfile", Mandatory)]
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
if($with_profile) {
    .\conan-imports.ps1 -with_profile -build_private $build_private -build_nfc $build_nfc -build_rfideas $build_rfideas
} else {
    .\conan-imports.ps1 -arch $arch -build_type $build_type -build_private $build_private -build_nfc $build_nfc -build_rfideas $build_rfideas
}
Set-Location ../sources/scripts
pip install -r requirements.txt
Set-Location ../../
.\sources/scripts/update-gitversion-vs2017proj.ps1 sources/LibLogicalAccessNet/LibLogicalAccessNet.csproj
.\sources/scripts/generate-swig.ps1
Set-Location sources/LibLogicalAccessNet.win32
if($with_profile) {
    .\conan-build.ps1 -with_profile -build_private $build_private -build_nfc $build_nfc -build_rfideas $build_rfideas
} else {
    ./conan-build.ps1 -arch $arch -build_type $build_type -build_private $build_private -build_nfc $build_nfc -build_rfideas $build_rfideas
}
Set-Location ..

msbuild -t:restore
if ($build_private) {
    msbuild LibLogicalAccessNet.sln /p:Configuration="Release"
} else {
    msbuild LibLogicalAccessNet.sln /p:Configuration="ReleaseCE"
}

Set-Location ..