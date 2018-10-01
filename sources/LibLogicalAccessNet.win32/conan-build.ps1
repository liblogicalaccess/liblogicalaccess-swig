[CmdletBinding()]
param( 
  [Parameter(Mandatory=$false)]
  [bool]$allConfig
)

. islog-utils.ps1

Write-Output "Welcome, ISLOG SWIG Win32 Build"

'build','bin/x86/Release','bin/x86/Debug','bin/x86_64/Release','bin/x86_64/Debug' | % {New-Item -Name "$_" -Force -ItemType 'Directory' | Out-Null }

cd build

#x64 Release
Exec-External { conan install -p compilers/x64_msvc_release -u .. }
Exec-External { conan build .. }
cp bin/LibLogicalAccessNet.win32.* ../bin/x86_64/Release/
Remove-Item * -Recurse -Force
#x86 Release
Exec-External { conan install -p compilers/x86_msvc_release -u .. }
Exec-External { conan build .. }
cp bin/LibLogicalAccessNet.win32.* ../bin/x86/Release/
Remove-Item * -Recurse -Force

if ($allConfig) {
	#x86 Debug
	Exec-External { conan install -p compilers/x86_msvc_debug -u .. }
	Exec-External { conan build .. }
	cp bin/LibLogicalAccessNet.win32.* ../bin/x86/Debug/
	Remove-Item * -Recurse -Force
	#x64 Debug
	Exec-External { conan install -p compilers/x64_msvc_debug -u .. }
	Exec-External { conan build .. }
	cp bin/LibLogicalAccessNet.win32.* ../bin/x86_64/Debug/
	Remove-Item * -Recurse -Force
}

cd ..

Write-Output "ISLOG SWIG Win32 done."