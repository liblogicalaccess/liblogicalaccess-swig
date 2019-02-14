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
$NuGetVersionV2 += $Env:BUILD_NUMBER
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