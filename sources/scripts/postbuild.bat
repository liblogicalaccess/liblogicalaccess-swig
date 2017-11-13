IF "%1" == "true" (
	Powershell.exe -executionpolicy remotesigned -File .\sources\scripts\sign.ps1 "%2"
)