Write-Host "Arg nbr: " $args.Length
if ($args.Length -lt 1)
{
    Write-Error -Message "Missing argument to script. End of script.";
    exit;
}

Try
{
    If ($args.Length -eq 2)
    {
        $namespace = $args[1];
    }
    Else
    {
        $namespace = "swig";
    }
    Write-Host "1";
    $curLoc = Get-Location;
    $path = "$curLoc\test_swig\swig\swig.csproj";
   
    $DirExists = Test-Path $curLoc\test_swig\swig\Exception
    If ($DirExists -eq $False)
    {
        New-Item $curLoc\test_swig\swig\Exception -type directory;
    }
    Write-Host "2";
    If (Test-Path -Path $curLoc\test_swig\swig\Exception\$($args[0]).cs)
    {
        While (($check = Read-Host -Prompt "The file $arg.cs already exist. Do you want to override it ?[y/n]") -ne "y" -And $check -ne "n")
        { }
        If ($check -eq "n")
        {
            Exit;
        }
        New-Item $curLoc"\test_swig\swig\Exception\$($args[0]).cs" -type file -force;
    }
    Else
    {
        New-Item $curLoc"\test_swig\swig\Exception\$($args[0]).cs" -type file;
    }
    Write-Host "3";
    Add-Content $curLoc"\test_swig\swig\Exception\"$($args[0]).cs "using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace $namespace
{
    class $($args[0]) : CustomException
    {
        public $($args[0])()
        {
        }

        public $($args[0])(string message)
            : base(message)
        {
        }

        public $($args[0])(string message, Exception inner)
            : base(message, inner)
        {
        }
    }
}"
    
    Write-Host $path;
    $xmlDoc = [xml](Get-Content $path);
    $fullInclude = "Exception\$($args[0]).cs";
    $nodeCount = ($xmlDoc.Project.ItemGroup[1].Compile|where { $_.Include -eq $fullInclude }).Include.Count;
    If ($nodeCount -eq 0)
    {
        Write-Host "Updating .csproj";
        $xmlNewElem = $xmlDoc.Project.ItemGroup[1].AppendChild($xmlDoc.CreateElement("Compile"));
        $xmlNewElem.SetAttribute("Include", "Exception\$($args[0]).cs");
        $xmlDoc = [xml]$xmlDoc.OuterXml.Replace(" xmlns=`"`"", "");
        $xmlDoc.Save($path);
    }
}
Catch
{
    Write-Error $_.Exception.Message;
    Exit;
}
Finally
{
    Remove-Item $curLoc"\"$($args[0]).cs -force
}