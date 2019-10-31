[CmdletBinding()]
param( 
  [Parameter(Mandatory=$false)]
  [bool]$publish
)

Import-Module IslogUtils

Write-Output "Welcome, ISLOG SWIG Win32 Build"

'build','bin/x86/Release','bin/x86/Debug','bin/x86_64/Release','bin/x86_64/Debug' | % {New-Item -Name "$_" -Force -ItemType 'Directory' | Out-Null }

cd build

$PackageName = "LogicalAccessSwig/2.1.0@islog/rc1"
$Profiles = @(("compilers/x64_msvc_release", "Release", "x86_64"),
			  ("compilers/x86_msvc_release", "Release", "x86"),
			  ("compilers/x86_msvc_debug", "Debug", "x86"),
			  ("compilers/x64_msvc_debug", "Debug", "x86_64"))

foreach ($Profile in $Profiles){

    ExecExternal { conan install -p $Profile[0] -u .. }
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