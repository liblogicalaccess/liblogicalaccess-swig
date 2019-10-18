[CmdletBinding()]
param( 
  [Parameter(Mandatory=$true)]
  [String]$projectFile
)

[xml]$s = get-content $projectFile
if ($s.Project.Sdk -eq $null -or !($s.Project.Sdk -eq "Microsoft.NET.Sdk")) {
	throw ("Error: $project is not a .NET SDK project")
}

$NuGetVersionV2=Gitversion /output json /showvariable NuGetVersionV2
$Branch=git rev-parse --abbrev-ref HEAD
$deveBranch = "develop", "heads/origin/develop", "origin/develop"
if (($Branch -in $deveBranch) -or ($Branch -match "^rc[0-9]$"))
{
    $buildNumber = $Env:BUILD_NUMBER
    $buildNumber = $buildNumber.padLeft(4, '0')
    if ($Branch -match '[0-9]$')
    {
        # Git version generate x.y.z-rc1-0001 if branch name
        # ends with a number
        $NuGetVersionV2 = $NuGetVersionV2.replace('-0001', "-$($buildNumber)")        
    }
    else
    {
        # GitVersion generate x.y.z-branchname0001 otherwise
        $NuGetVersionV2 = $NuGetVersionV2.replace('0001', "-$($buildNumber)")
    } 
}

$AssemblySemVer=Gitversion /output json /showvariable AssemblySemVer
$AssemblySemFileVer=Gitversion /output json /showvariable AssemblySemFileVer

if (!($s.Project.PropertyGroup -eq $null) -and !($s.Project.PropertyGroup[0] -eq $null))
{
	$s.Project.PropertyGroup[0].Version = "$NuGetVersionV2";
	$s.Project.PropertyGroup[0].AssemblyVersion = "$AssemblySemVer";
	$s.Project.PropertyGroup[0].FileVersion = "$AssemblySemFileVer";
	
	
	$fullProjectPath = (Get-Item -Path ".\").FullName + "\" + $projectFile
	$s.save($fullProjectPath)
}