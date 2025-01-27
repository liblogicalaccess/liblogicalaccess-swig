Param(
    [Parameter(ParameterSetName="WithProfile", Mandatory)]
    [switch]$with_profile,
    [Parameter(ParameterSetName="WithoutProfile", Mandatory)]
    [string]$arch,
    [Parameter(ParameterSetName="WithoutProfile", Mandatory)]
    [string]$build_type,
    [Parameter(Mandatory=$false)]
    [bool]$build_nfc
)

if($with_profile) {
    conan install -pr compilers/x64_msvc_debug -u -o LLA_BUILD_NFC=$build_nfc .
    conan install -pr compilers/x64_msvc_release -u -o LLA_BUILD_NFC=$build_nfc .
    conan install -pr compilers/x86_msvc_debug -u -o LLA_BUILD_NFC=$build_nfc .
    conan install -pr compilers/x86_msvc_release -u -o LLA_BUILD_NFC=$build_nfc .
} else {
    conan install -s arch=$arch -s build_type=$build_type -u -o LLA_BUILD_NFC=$build_nfc --build=missing .
}