Param(
    [Parameter(ParameterSetName="WithProfile", Mandatory)]
    [switch]$with_profile,
    [Parameter(ParameterSetName="WithoutProfile", Mandatory)]
    [string]$arch,
    [Parameter(ParameterSetName="WithoutProfile", Mandatory)]
    [string]$build_type,
    [Parameter(Mandatory=$false)]
    [bool]$build_nfc,
	[Parameter(Mandatory=$false)]
    [bool]$build_unittest
)

Write-Host $arch $build_type $build_nfc
Set-Location installer
if($with_profile) {
    .\conan-imports.ps1 -with_profile -build_nfc $build_nfc -build_unittest $build_unittest
} else {
    .\conan-imports.ps1 -arch $arch -build_type $build_type -build_nfc $build_nfc -build_unittest $build_unittest
}
Set-Location ../sources/scripts
pip install -r requirements.txt
Set-Location ../../
.\sources/scripts/update-gitversion-vs2017proj.ps1 sources/LibLogicalAccessNet/LibLogicalAccessNet.csproj
.\sources/scripts/generate-swig.ps1
Set-Location sources/LibLogicalAccessNet.native
if($with_profile) {
    .\conan-build.ps1 -with_profile -build_nfc $build_nfc -build_unittest $build_unittest
} else {
    ./conan-build.ps1 -arch $arch -build_type $build_type -build_nfc $build_nfc -build_unittest $build_unittest
}
Set-Location ..

msbuild -t:restore
msbuild LibLogicalAccessNet.sln /p:Configuration="Release"

Set-Location ..
