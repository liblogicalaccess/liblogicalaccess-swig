[CmdletBinding()]
param( 
  [Parameter(Mandatory=$false)]
  [bool]$allConfig,
  
  [Parameter(Mandatory=$false)]
  [bool]$publish
)

. islog-utils.ps1

Write-Output "Welcome, ISLOG SWIG Win32 Build"

'build','bin/x86/Release','bin/x86/Debug','bin/x86_64/Release','bin/x86_64/Debug' | % {New-Item -Name "$_" -Force -ItemType 'Directory' | Out-Null }

cd build

$PackageName = "LogicalAccessSwig/3.1.0@islog/develop"
$Profiles = @(("compilers/x64_msvc_release", "Release", "x86_64"),
			  ("compilers/x86_msvc_release", "Release", "x86"),
			  ("compilers/x86_msvc_debug", "Debug", "x86"),
			  ("compilers/x64_msvc_debug", "Debug", "x86_64"))

foreach ($Profile in $Profiles){

	if ($allConfig -or ($Profile[1] -eq "Release"))
	{
		Exec-External { conan install -p $Profile[0] -u .. }
		Exec-External { conan build .. }
		if ($publish) {
			Exec-External { conan package .. }
			Exec-External { conan upload ${PACKAGE_NAME} -r islog-test --all --confirm --check --force }
		}
		cp bin/LibLogicalAccessNet.win32.* ../bin/$Profile[2]/Release/
		Remove-Item * -Recurse -Force*
	}
}

cd ..

Write-Output "ISLOG SWIG Win32 done."