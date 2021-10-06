[CmdletBinding()]
param( 
  [Parameter(Mandatory=$false)]
  [switch]$publish,
  [Parameter(Mandatory=$false)]
  [switch]$ce
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

'build','bin/x86/Release','bin/x86/Debug','bin/x86_64/Release','bin/x86_64/Debug' | % {New-Item -Name "$_" -Force -ItemType 'Directory' | Out-Null }

cd build

$PackageName = "LogicalAccessSwig/2.4.0@islog/develop"
$Profiles = @(("compilers/x64_msvc_release", "Release", "x86_64"),
			  ("compilers/x86_msvc_release", "Release", "x86"),
			  ("compilers/x86_msvc_debug", "Debug", "x86"),
			  ("compilers/x64_msvc_debug", "Debug", "x86_64"))
$buildPrivate = $True
if ($ce) {
	$buildPrivate = $False
	$env:ASSEMBLYAPPENDER = 'CE'
}

foreach ($Profile in $Profiles){

    ExecExternal { conan install --profile $Profile[0] -o LLA_BUILD_PRIVATE=$buildPrivate -u .. }
    ExecExternal { conan build .. }
    $config = $Profile[1];
    $arch = $Profile[2];
    cp bin/LibLogicalAccessNet.win32.* ../bin/$arch/$config/
    if ($publish) {
        ExecExternal { conan export-pkg .. $PackageName }
        ExecExternal { conan upload $PackageName -r islog-test --all --confirm --check }
    }
    Remove-Item * -Recurse -Force
}

cd ..

Write-Output "ISLOG SWIG Win32 done."