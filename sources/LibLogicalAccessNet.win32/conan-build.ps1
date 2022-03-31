[CmdletBinding()]
param( 
  [Parameter(Mandatory=$false)]
  [switch]$publish,
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

function ExecExternal {
  param(
	[Parameter(Position=0,Mandatory=1)][scriptblock] $command
  )
  & $command
  if ($LASTEXITCODE -ne 0) {
	throw ("Command returned non-zero error-code ${LASTEXITCODE}: $command")
  }
}

Write-Output "Welcome, ISLOG SWIG Win32 Build"

New-Item -name build -Force -ItemType Directory | Out-Null
New-Item -Name bin/$arch/$build_type -Force -ItemType Directory | Out-Null

Set-Location build

$PackageName = "LogicalAccessSwig/2.4.0@islog/develop"

if ($build_private) {
	$env:ASSEMBLYAPPENDER = 'CE'
}

ExecExternal { conan install -s arch=$arch -s build_type=$build_type -o LLA_BUILD_PRIVATE=$build_private -o LLA_BUILD_NFC=$build_nfc -o LLA_BUILD_RFIDEAS=$build_rfideas --build=missing .. }
ExecExternal { conan build .. }

Copy-Item bin/LibLogicalAccessNet.win32.* ../bin/$arch/$build_type/

if ($publish) {
    ExecExternal { conan export-pkg .. $PackageName }
    ExecExternal { conan upload $PackageName -r islog-test --all --confirm --check }
}

Remove-Item * -Recurse -Force

Set-Location ..

Write-Output "ISLOG SWIG Win32 done."