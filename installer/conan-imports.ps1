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

if($with_profile) {
    conan install -pr compilers/x64_msvc_debug -o LLA_BUILD_NFC=$build_nfc -o LLA_BUILD_UNITTEST=$build_unittest -u .
    conan install -pr compilers/x64_msvc_release -o LLA_BUILD_NFC=$build_nfc -o LLA_BUILD_UNITTEST=$build_unittest -u .
    conan install -pr compilers/x86_msvc_debug -o LLA_BUILD_NFC=$build_nfc -o LLA_BUILD_UNITTEST=$build_unittest -u .
    conan install -pr compilers/x86_msvc_release -o LLA_BUILD_NFC=$build_nfc -o LLA_BUILD_UNITTEST=$build_unittest -u .
} else {
    conan install -s arch=$arch -s build_type=$build_type -o LLA_BUILD_NFC=$build_nfc -o LLA_BUILD_UNITTEST=$build_unittest --build=missing -u .
}