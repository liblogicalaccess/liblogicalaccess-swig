Option Explicit
Dim objShell
Set objShell = CreateObject("WScript.Shell")

Dim strComputer, ArrOfValue, oReg
const HKEY_USERS = &H80000003
const HKEY_LOCAL_MACHINE = &H80000002
const HKEY_CURRENT_USER = &H80000001
const HKEY_CLASSES_ROOT = &H80000000
strComputer = "."
Set oReg=GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & strComputer & "\root\default:StdRegProv")
objShell.RegWrite "HKLM\SYSTEM\CurrentControlSet\services\SCardSvr\", ""
objShell.RegWrite "HKLM\SYSTEM\CurrentControlSet\services\SCardSvr\DisplayName", "Smart Card", "REG_SZ"
objShell.RegWrite "HKLM\SYSTEM\CurrentControlSet\services\SCardSvr\Group", "SmartCardGroup", "REG_SZ"
ArrOfValue = Array(&H25,&H00,&H53,&H00,&H79,&H00,&H73,&H00,&H74,&H00,&H65,&H00,&H6d,&H00,&H52,&H00,&H6f,&H00,&H6f,&H00,_
&H74,&H00,&H25,&H00,&H5c,&H00,&H73,&H00,&H79,&H00,&H73,&H00,&H74,&H00,&H65,&H00,&H6d,&H00,&H33,&H00,&H32,&H00,&H5c,&H00,&H73,_
&H00,&H76,&H00,&H63,&H00,&H68,&H00,&H6f,&H00,&H73,&H00,&H74,&H00,&H2e,&H00,&H65,&H00,&H78,&H00,&H65,&H00,&H20,&H00,&H2d,&H00,_
&H6b,&H00,&H20,&H00,&H4c,&H00,&H6f,&H00,&H63,&H00,&H61,&H00,&H6c,&H00,&H53,&H00,&H65,&H00,&H72,&H00,&H76,&H00,&H69,&H00,&H63,_
&H00,&H65,&H00,&H41,&H00,&H6e,&H00,&H64,&H00,&H4e,&H00,&H6f,&H00,&H49,&H00,&H6d,&H00,&H70,&H00,&H65,&H00,&H72,&H00,&H73,&H00,_
&H6f,&H00,&H6e,&H00,&H61,&H00,&H74,&H00,&H69,&H00,&H6f,&H00,&H6e,&H00,&H00,&H00)
oReg.SetExpandedStringValue HKEY_LOCAL_MACHINE, "SYSTEM\CurrentControlSet\services\SCardSvr", "ImagePath", ArrOfValue

objShell.RegWrite "HKLM\SYSTEM\CurrentControlSet\services\SCardSvr\Description", "@%SystemRoot%\\System32\\SCardSvr.dll,-5", "REG_SZ"
objShell.RegWrite "HKLM\SYSTEM\CurrentControlSet\services\SCardSvr\ObjectName", "NT AUTHORITY\\LocalService", "REG_SZ"
objShell.RegWrite "HKLM\SYSTEM\CurrentControlSet\services\SCardSvr\ErrorControl", 1, "REG_DWORD"
objShell.RegWrite "HKLM\SYSTEM\CurrentControlSet\services\SCardSvr\Start", 2, "REG_DWORD"
objShell.RegWrite "HKLM\SYSTEM\CurrentControlSet\services\SCardSvr\Type", 32, "REG_DWORD"
ArrOfValue = Array(&H50,&H00,&H6c,&H00,&H75,&H00,&H67,&H00,&H50,&H00,&H6c,&H00,&H61,&H00,&H79,&H00,&H00,&H00,_
&H00,&H00)
oReg.SetMultiStringValue HKEY_LOCAL_MACHINE, "SYSTEM\CurrentControlSet\services\SCardSvr", "DependOnService", ArrOfValue

objShell.RegWrite "HKLM\SYSTEM\CurrentControlSet\services\SCardSvr\ServiceSidType", 1, "REG_DWORD"
ArrOfValue = Array(&H53,&H00,&H65,&H00,&H43,&H00,&H72,&H00,&H65,&H00,&H61,&H00,&H74,&H00,&H65,&H00,&H47,_
&H00,&H6c,&H00,&H6f,&H00,&H62,&H00,&H61,&H00,&H6c,&H00,&H50,&H00,&H72,&H00,&H69,&H00,&H76,&H00,&H69,&H00,&H6c,&H00,&H65,&H00,_
&H67,&H00,&H65,&H00,&H00,&H00,&H53,&H00,&H65,&H00,&H43,&H00,&H68,&H00,&H61,&H00,&H6e,&H00,&H67,&H00,&H65,&H00,&H4e,&H00,&H6f,_
&H00,&H74,&H00,&H69,&H00,&H66,&H00,&H79,&H00,&H50,&H00,&H72,&H00,&H69,&H00,&H76,&H00,&H69,&H00,&H6c,&H00,&H65,&H00,&H67,&H00,_
&H65,&H00,&H00,&H00,&H00,&H00)
oReg.SetMultiStringValue HKEY_LOCAL_MACHINE, "SYSTEM\CurrentControlSet\services\SCardSvr", "RequiredPrivileges", ArrOfValue

ArrOfValue = Array(&H84,&H03,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H03,&H00,&H00,&H00,&H14,&H00,&H00,_
&H00,&H01,&H00,&H00,&H00,&Hc0,&Hd4,&H01,&H00,&H01,&H00,&H00,&H00,&He0,&H93,&H04,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00)
oReg.SetBinaryValue HKEY_LOCAL_MACHINE, "SYSTEM\CurrentControlSet\services\SCardSvr", "FailureActions", ArrOfValue

objShell.RegWrite "HKLM\SYSTEM\CurrentControlSet\services\SCardSvr\Parameters\", ""
ArrOfValue = Array(&H25,&H00,&H53,&H00,&H79,&H00,&H73,&H00,&H74,&H00,&H65,&H00,&H6d,&H00,&H52,&H00,&H6f,&H00,&H6f,_
&H00,&H74,&H00,&H25,&H00,&H5c,&H00,&H53,&H00,&H79,&H00,&H73,&H00,&H74,&H00,&H65,&H00,&H6d,&H00,&H33,&H00,&H32,&H00,&H5c,&H00,_
&H53,&H00,&H43,&H00,&H61,&H00,&H72,&H00,&H64,&H00,&H53,&H00,&H76,&H00,&H72,&H00,&H2e,&H00,&H64,&H00,&H6c,&H00,&H6c,&H00,&H00,_
&H00)
oReg.SetBinaryValue HKEY_LOCAL_MACHINE, "SYSTEM\CurrentControlSet\services\SCardSvr\", "ServiceDll", ArrOfValue
objShell.RegWrite "HKLM\SYSTEM\CurrentControlSet\services\SCardSvr\Parameters\ServiceMain", "CalaisMain", "REG_SZ"
objShell.RegWrite "HKLM\SYSTEM\CurrentControlSet\services\SCardSvr\Parameters\ServiceDllUnloadOnStop", 1, "REG_DWORD"

objShell.RegWrite "HKLM\SYSTEM\CurrentControlSet\services\SCardSvr\Security\", ""
ArrOfValue = Array(&H01,&H00,&H14,&H80,&H90,&H00,&H00,&H00,&Ha0,&H00,&H00,&H00,&H14,&H00,&H00,&H00,&H34,&H00,&H00,&H00,&H02,_
&H00,&H20,&H00,&H01,&H00,&H00,&H00,&H02,&Hc0,&H18,&H00,&H00,&H00,&H0c,&H00,&H01,&H02,&H00,&H00,&H00,&H00,&H00,&H05,&H20,&H00,_
&H00,&H00,&H20,&H02,&H00,&H00,&H02,&H00,&H5c,&H00,&H04,&H00,&H00,&H00,&H00,&H02,&H14,&H00,&Hff,&H01,&H0f,&H00,&H01,&H01,&H00,_
&H00,&H00,&H00,&H00,&H05,&H12,&H00,&H00,&H00,&H00,&H00,&H18,&H00,&Hff,&H01,&H02,&H00,&H01,&H02,&H00,&H00,&H00,&H00,&H00,&H05,_
&H20,&H00,&H00,&H00,&H20,&H02,&H00,&H00,&H00,&H00,&H14,&H00,&H8d,&H01,&H02,&H00,&H01,&H01,&H00,&H00,&H00,&H00,&H00,&H05,&H04,_
&H00,&H00,&H00,&H00,&H00,&H14,&H00,&H8d,&H01,&H02,&H00,&H01,&H01,&H00,&H00,&H00,&H00,&H00,&H05,&H06,&H00,&H00,&H00,&H01,&H02,_
&H00,&H00,&H00,&H00,&H00,&H05,&H20,&H00,&H00,&H00,&H20,&H02,&H00,&H00,&H01,&H02,&H00,&H00,&H00,&H00,&H00,&H05,&H20,&H00,&H00,_
&H00,&H20,&H02,&H00,&H00)
oReg.SetBinaryValue HKEY_LOCAL_MACHINE, "SYSTEM\CurrentControlSet\services\SCardSvr\Security", "Security", ArrOfValue

Set objShell = Nothing
WScript.Quit
