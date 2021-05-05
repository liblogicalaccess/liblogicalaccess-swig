[CmdletBinding()]
param( 
  [Parameter(Mandatory=$true)]
  [String]$projectFile
)

function GetGitVersion {
	param()
	
    $Branch=GitVersion.exe /output json /showvariable BranchName
    $masterBranch = "master", "v1", "v2"
	$version=GitVersion.exe /output json /showvariable NuGetVersionV2
    if (!($Branch -in $masterBranch) -and (Test-Path env:BUILD_NUMBER))
    {
        $version = GitVersion.exe /output json /showvariable MajorMinorPatch
        $buildNumber = $Env:BUILD_NUMBER
        $buildNumber = $buildNumber.padLeft(4, '0')
        $version += "-" + $Branch + "-" + $buildNumber
        git tag -a $version -m 'tag for gitversion'
    }
	return $version
}


[xml]$s = get-content $projectFile
if ($s.Project.Sdk -eq $null -or !($s.Project.Sdk -eq "Microsoft.NET.Sdk")) {
	throw ("Error: $project is not a .NET SDK project")
}

$NuGetVersionV2=GetGitVersion
$AssemblySemVer=Gitversion /output json /showvariable AssemblySemVer
$AssemblySemFileVer=Gitversion /output json /showvariable AssemblySemFileVer

if (!($s.Project.PropertyGroup -eq $null) -and !($s.Project.PropertyGroup[0] -eq $null))
{
	Write-Output "Update Version to "$NuGetVersionV2
	Write-Output "Update AssemblyVersion to "$AssemblySemVer
	Write-Output "Update FileVersion to "$AssemblySemFileVer
	$s.Project.PropertyGroup[0].Version = "$NuGetVersionV2";
	$s.Project.PropertyGroup[0].AssemblyVersion = "$AssemblySemVer";
	$s.Project.PropertyGroup[0].FileVersion = "$AssemblySemFileVer";
	
	
	$fullProjectPath = (Get-Item -Path ".\").FullName + "\" + $projectFile
	$s.save($fullProjectPath)
}