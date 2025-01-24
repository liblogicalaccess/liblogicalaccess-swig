[CmdletBinding()]
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
    [bool]$build_unittest,
    [Parameter(Mandatory=$false)]
    [switch]$publish
)

function ExecExternal {
  param(
	[Parameter(Position=0,Mandatory=1)][scriptblock] $command
  )
  & $command
  if ($LASTEXITCODE -ne 0) {
	throw ("Command returned non-zero error-code ${LASTEXITCODE}: $command")
  }
}

Write-Output "Welcome, LLA SWIG Native Build"

New-Item -name build -Force -ItemType Directory | Out-Null
if($with_profile) {
  'bin/x86/Release','bin/x86/Debug','bin/x86_64/Release','bin/x86_64/Debug' | ForEach-Object { New-Item -Name "$_" -Force -ItemType Directory | Out-Null }
} else {
  New-Item -Name bin/$arch/$build_type -Force -ItemType Directory | Out-Null  
}

Set-Location build

$PackageName = "LogicalAccessSwig/3.2.0@lla/master"
$Profiles = @(("compilers/x64_msvc_release", "Release", "x86_64"),
			  ("compilers/x86_msvc_release", "Release", "x86"),
			  ("compilers/x86_msvc_debug", "Debug", "x86"),
			  ("compilers/x64_msvc_debug", "Debug", "x86_64"))  

$env:ASSEMBLYAPPENDER = 'CE'

if($with_profile) {
  foreach ($Profile in $Profiles) {
    ExecExternal { conan install -pr $Profile[0] -o LLA_BUILD_NFC=$build_nfc -o LLA_BUILD_UNITTEST=$build_unittest --build=missing .. }
    ExecExternal { conan build .. }
    $config = $Profile[1]
    $arch = $Profile[2]
    Copy-Item bin/LibLogicalAccessNet.native.* ../bin/$arch/$config/
    if ($publish) {
      ExecExternal { conan export-pkg .. $PackageName }
      ExecExternal { conan upload $PackageName -r islog-test --all --confirm --check }
    }
	Remove-Item * -Recurse -Force
  }
} else {
  ExecExternal { conan install -s arch=$arch -s build_type=$build_type -o LLA_BUILD_NFC=$build_nfc -o LLA_BUILD_UNITTEST=$build_unittest --build=missing .. }
  ExecExternal { conan build .. }
  Copy-Item bin/LibLogicalAccessNet.native.* ../bin/$arch/$build_type/
  if ($publish) {
    ExecExternal { conan export-pkg .. $PackageName }
    ExecExternal { conan upload $PackageName -r islog-test --all --confirm --check --force}
  }
  Remove-Item * -Recurse -Force
}

Set-Location ..

Write-Output "LLA SWIG Native done."
