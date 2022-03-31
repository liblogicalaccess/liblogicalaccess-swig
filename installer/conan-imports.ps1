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

conan install -s arch=$arch -s build_type=$build_type -o LLA_BUILD_PRIVATE=$build_private -o LLA_BUILD_NFC=$build_nfc -o LLA_BUILD_RFIDEAS=$build_rfideas --build=missing -u .