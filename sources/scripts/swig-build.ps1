cd ..

rm .\LibLogicalAccessNet\Generated\*.cs
rm .\LibLogicalAccessNet\Generated\Reader\*.cs
rm .\LibLogicalAccessNet\Generated\Card\*.cs
rm .\LibLogicalAccessNet\Generated\Core\*.cs
rm .\LibLogicalAccessNet\Generated\Crypto\*.cs

$Commands = @((".\LibLogicalAccessNet\Generated\Card", "LibLogicalAccess.Card", ".\LibLogicalAccessNet.win32\liblogicalaccess_card.i"),
            (".\LibLogicalAccessNet\Generated", "LibLogicalAccess", ".\LibLogicalAccessNet.win32\liblogicalaccess_data.i"),
            (".\LibLogicalAccessNet\Exception", "LibLogicalAccess", ".\LibLogicalAccessNet.win32\liblogicalaccess_exception.i"),
            (".\LibLogicalAccessNet\Generated", "LibLogicalAccess", ".\LibLogicalAccessNet.win32\liblogicalaccess_library.i"),
            (".\LibLogicalAccessNet\Generated\Reader", "LibLogicalAccess.Reader", ".\LibLogicalAccessNet.win32\liblogicalaccess_reader.i"),
            (".\LibLogicalAccessNet\Generated", "LibLogicalAccess", ".\LibLogicalAccessNet.win32\liblogicalaccess_iks.i"),
            (".\LibLogicalAccessNet\Generated\Crypto", "LibLogicalAccess.Crypto", ".\LibLogicalAccessNet.win32\liblogicalaccess_crypto.i"),
            (".\LibLogicalAccessNet\Generated\Core", "LibLogicalAccess", ".\LibLogicalAccessNet.win32\liblogicalaccess_core.i"))

$currentFolder = (Get-Item -Path ".\" -Verbose).FullName

$RunspaceCollection = @()
[Collections.Arraylist]$qwinstaResults = @()
$RunspacePool = [RunspaceFactory]::CreateRunspacePool(1,30)
$RunspacePool.Open()

$ScriptBlock = {
	Param(
		[string]$currentFolder,
		[string]$outdir,
		[string]$namespace,
		[string]$interface
	)
	
	Try
	{
		cd $currentFolder
        $cmd = $env:SWIG + "\swig.exe"
		$currentPath = (Get-Item -Path ".\" -Verbose).FullName + "\..\installer\packages\include"
	
		$output = & $cmd -csharp -c++ -I"$currentPath" -outdir $outdir -namespace $namespace -dllimport LibLogicalAccessNet.win32.dll $interface 2>&1
		
		if ($LASTEXITCODE -ne 0) {
			throw ("Command returned non-zero error-code ${LASTEXITCODE}: $cmd -csharp -c++ -I$currentPath -outdir $outdir -namespace $namespace -dllimport LibLogicalAccessNet.win32.dll $interface`n$output")
		}

		return $output;
	}
	Catch
	{
		return $_.Exception.Message;
	}
}

foreach ($Command in $Commands){
	$Powershell = [PowerShell]::Create().AddScript($ScriptBlock).AddParameters(@($currentFolder, $Command[0], $Command[1], $Command[2]))
	$Powershell.RunspacePool = $RunspacePool
	[Collections.Arraylist]$RunspaceCollection += New-Object -TypeName PSObject -Property @{
		Runspace = $PowerShell.BeginInvoke()
		PowerShell = $PowerShell  
	}
}
$Failed=$false
While($RunspaceCollection) {
	Foreach ($Runspace in $RunspaceCollection.ToArray()) {
		If ($Runspace.Runspace.IsCompleted) {
			$output = $Runspace.PowerShell.EndInvoke($Runspace.Runspace)
			if (![string]::IsNullOrEmpty($output)) {
				Write-Output $output
				$Failed=$true
			}
			$Runspace.PowerShell.Dispose()
			$RunspaceCollection.Remove($Runspace)
		}
	}
}

if ($Failed) {
	cd ..
	throw ("SWIG generation failed.")
}

cd scripts