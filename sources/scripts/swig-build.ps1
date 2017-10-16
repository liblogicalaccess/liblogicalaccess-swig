cd ..

rm .\LibLogicalAccessNet\Generated\*.cs
rm .\LibLogicalAccessNet\Generated\Reader\*.cs
rm .\LibLogicalAccessNet\Generated\Card\*.cs
rm .\LibLogicalAccessNet\Generated\Core\*.cs

$Commands = @((".\LibLogicalAccessNet\Generated\Card", "LibLogicalAccess.Card", ".\LibLogicalAccessNet.win32\liblogicalaccess_card.i"),
            (".\LibLogicalAccessNet\Generated", "LibLogicalAccess", ".\LibLogicalAccessNet.win32\liblogicalaccess_data.i"),
            (".\LibLogicalAccessNet\Exception", "LibLogicalAccess", ".\LibLogicalAccessNet.win32\liblogicalaccess_exception.i"),
            (".\LibLogicalAccessNet\Generated", "LibLogicalAccess", ".\LibLogicalAccessNet.win32\liblogicalaccess_library.i"),
            (".\LibLogicalAccessNet\Generated\Reader", "LibLogicalAccess.Reader", ".\LibLogicalAccessNet.win32\liblogicalaccess_reader.i"),
            (".\LibLogicalAccessNet\Generated", "LibLogicalAccess", ".\LibLogicalAccessNet.win32\liblogicalaccess_iks.i"),
            (".\LibLogicalAccessNet\Generated\Core", "LibLogicalAccess", ".\LibLogicalAccessNet.win32\liblogicalaccess_core.i"))

foreach ($Command in $Commands){
	Start-Job -Init ([ScriptBlock]::Create("Set-Location $pwd")) -ArgumentList $Command  {

        $cmd = $env:SWIG + "\swig.exe"
		$currentPath = (Get-Item -Path ".\" -Verbose).FullName + "\..\packages\include"
		& $cmd -csharp -c++ -I"$currentPath" -outdir $args[0] -namespace $args[1] -dllimport LibLogicalAccessNet.win32.dll $args[2]
				
		if ($LASTEXITCODE -ne 0) {
			throw ("Command returned non-zero error-code ${LASTEXITCODE}: ${command}")
		}
	}
}


Get-Job | Wait-Job

foreach ($Job in Get-Job){
	$Job
    "Code = $($Job.State)"
	"****************************************"
	Receive-Job $Job
	" " 
	Remove-Job $Job
}

cd scripts