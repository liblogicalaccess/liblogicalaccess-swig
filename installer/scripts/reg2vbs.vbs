'Reg2Vbs v1.5a
'Original Reg2Vbs v1.0 coded by Tim Mortimer
'Enhanced Reg2Vbs v1.51 by Denis St-Pierre (Ottawa, Canada)
'License: Public Domain
'
'Purpose: converts ALL reg files in current directory to VBS in one shot!
'OS:	  works in 2k and up
'Liability: Use at your own risk!
'
'v1.5 features:
'Handles REG_SZ, REG_DWORD, BINARY (U/A), MULTI-SZ, EXPAND_SZ and Default values (lines that start with @= )
'Handles Comments (lines that start with ;)
'Handles Comments at end of DWORD lines
'Handles values and data containing Chr(34), if encountered Chr(34) will be removed or processed (Default,REG_SZ) to prevent corrupt output file
'Adds blank line after each BINARY, MULTI-SZ, and EXPAND_SZ blocks (easier to read vbs)
'Handles deletion of keys or values using the "-" identifier
'UNsupported values are commented into VBS file

'v1.5 Limitations:
'Cannot handle comments at end of MULTI-SZ, BINARY and EXPAND_SZ lines (never will)
'Cannot handle @="\"c:\blabla\""	default values for some reason
'Cannot handle Hex values that end without ",00" or ",00,00"
'Cannot handle Key names containing Chr(34)	NOTE: Key names with " are valid (see paper sizes in registry)
'CAVEAT:last line in REG file needs to be blank or else last line is ignored

'
'v1.0 Limitations:
'1 - Only HKEY_CLASSES_ROOT, HKEY_CURRENT_USER and HKEY_LOCAL_MACHINE root keys are supported
'2 - Only REG_SZ and REG_DWORD values are supported
'3 - Keys, values and data containing Chr(34) are not supported and, if encountered, will cause corrupt output file
'4 - Deletion of keys or values using the "-" identifier is not supported
'5 - Comments are not handled

Option Explicit

'Constant declarations
Const sDelim = "|"
Const ForReading = 1
Const TristateUseDefault = -2
const HKEY_LOCAL_MACHINE = &H80000002

'Global declarations
Dim FSO, g_KEY, g_Err, g_CurrentFile, g_long_HKEY

Set FSO = CreateObject("Scripting.FileSystemObject") 'Initialize the file system object

Dim sFiles
Dim nFiles
Dim i, bDoingMultiSZ, bUsingStdRegProv, strMultiValue, MultiValue
Dim bDoingBINARY, strBINARYValue,bDoingUnicode, strEXPANDSZValue, bDoingEXPANDSZ


'Add key - Set global key values
Dim l_HKEY, l_LenHKEY, l_SubKey
Dim g_Value

g_Err = "" 'Initialize global error object

'setting default values
bDoingBINARY=False
strBINARYValue=False
bDoingUnicode=False

'Get a list of reg files in the current directory and sort into an array
sFiles = Split(GetRegFiles, sDelim)
'Get number of files
nFiles = UBound(sFiles) - 1
'Loop through all files
For i = 0 To nFiles
	'Set global current file
	g_CurrentFile = sFiles(i)
	MsgBox "Openning "&g_CurrentFile
	'Convert the file
	If (Not ConvertFile(g_CurrentFile)) Then
		MsgBox "An error occurred while converting the file: " & sFiles(i), vbCritical, "Error - reg2vbs"
	End If
Next

'create log file
If Len(g_Err) > 0 Then
	MsgBox "Errors where encountered while converting the files.  Check error.log for details", vbCritical, "Conversion Completed - Errors"
	Dim hErrFile
	Set hErrFile = FSO.CreateTextFile("error.log", True)
	PrependLine g_Err, "Created: " & Now
	PrependLine g_Err, "Reg2Vbs v1.5 Error Log"
	PrependLine g_Err, "<-------------------- START ERROR LOG -------------------->"
	AppendLine g_Err, "<--------------------- END ERROR LOG --------------------->"
	hErrFile.Write g_Err
	hErrFile.Close
	Set hErrFile = Nothing
End If

MsgBox "All .reg files have been converted"
'Free thefile system object
Set FSO = Nothing
WScript.Quit


' ======================================================================================================
' ======================================================================================================
'
'				FUNCTIONS Used
'
' ======================================================================================================
' ======================================================================================================
'Function IsRegFile(sFile)
	'Checks for valid file extension
'	IsRegFile = (LCase(FSO.GetExtensionName(sFile)) = "reg")
'End Function


Function GetRegFiles()
	'Find all *.reg files in the current directory
	Dim oDir
	Dim oFile
	Dim oFiles
	Dim sCurrentDir
	Dim sResult
	'Get current directory
	sCurrentDir = Left(WScript.ScriptFullName, Len(WScript.ScriptFullName) - Len(WScript.ScriptName))
	'Obtain handle to directory
	Set oDir = FSO.GetFolder(sCurrentDir)
	'Retrieve list of files in current directory
	Set oFiles = oDir.Files
	For Each oFile In oFiles
		'Check for valid extension
		If LCase(FSO.GetExtensionName(oFile.Name)) = "reg" Then 'Checks for valid file extension
			'Add reg filename to result
			sResult = sResult & oFile.Path & sDelim
		End If
	Next
	'Assign function return value
	GetRegFiles = sResult
End Function



Function IsValidRegFile(sFirstLine)
	'Checks for valid registry file
	Dim Result
	Select Case sFirstLine
	Case "Windows Registry Editor Version 5.00"
		'Windows 2000, XP
		Result = True
	Case "REGEDIT4"
		'Windows 95, 98 ME
		Result = True
	Case Else
		'Unknown registry file format
		Result = False
	End Select
	IsValidRegFile = Result
End Function


Function ConvertFile(sFile)
	'Converts the registry file to a vbscript file
	Dim hRegFile
	Dim hVBSFile
	Dim sRegFile
	Dim sVBSFile
	Dim sVBSBuffer

	'Initialize the buffer
	sVBSBuffer = ""
	'Open the file as for reading in default system format (ANSI or Unicode)
	Set hRegFile = FSO.OpenTextFile(sFile, ForReading, False, TristateUseDefault)
	'Read the file contents into the buffer
	sRegFile = hRegFile.ReadAll
	'Split the buffer into an vbCrLf delimitered array
	sRegFile = Split(sRegFile, vbCrLf)

	If IsValidRegFile(sRegFile(0)) Then	'if reg file is valid continue
		'Create initial vbs code
		AppendLine sVBSBuffer, "'VBScript Registry File created with Reg2VBS v1.5"
		AppendLine sVBSBuffer, "'v1.0 Coded by Tim Mortimer"
		AppendLine sVBSBuffer, "'v1.5 Coded by Denis St-Pierre (ottawa, Canada)"
		AppendLine sVBSBuffer, "'Creation time: " & Now
		AppendLine sVBSBuffer, "Option Explicit"
		AppendLine sVBSBuffer, "Dim objShell"
		AppendLine sVBSBuffer, "Set objShell = CreateObject(""WScript.Shell"")"
		'AppendLine sVBSBuffer, ""
		
		'Add StdRegProv support in case of Binary, Multi_SZ values
		AppendLine sVBSBuffer, ""
		AppendLine sVBSBuffer, "'Add StdRegProv support in case of Binary, Multi_SZ values"
		AppendLine sVBSBuffer, "Dim strComputer, ArrOfValue, oReg"
		AppendLine sVBSBuffer, "const HKEY_USERS = &H80000003"
		AppendLine sVBSBuffer, "const HKEY_LOCAL_MACHINE = &H80000002"
		AppendLine sVBSBuffer, "const HKEY_CURRENT_USER = &H80000001"
		AppendLine sVBSBuffer, "const HKEY_CLASSES_ROOT = &H80000000"
		AppendLine sVBSBuffer, "strComputer = ""."""
		AppendLine sVBSBuffer, "Set oReg=GetObject(""winmgmts:{impersonationLevel=impersonate}!\\"" & strComputer & ""\root\default:StdRegProv"")	'used for Binary, Multi_SZ values"
		
		
		Dim sVBSLine
		Dim i
		For i = 1 to ubound(sRegFile) - 1 'Start at line 1 to avoid the header
			'Check for blank lines
			If Len(Trim(sRegFile(i))) > 0 Then
				sVBSLine = ConvertLine(sRegFile(i)) 'Convert registry line into vbscript equivalent
				AppendLine sVBSBuffer, sVBSLine		'Add converted line to sVBSBuffer
			Else
				'Blank line.  Do nothing.
			End If
		Next
		'Create the vbs filename
		sVBSFile = Left(sFile, Len(sFile) - 3) & "vbs"

		'Add trailing code
		AppendLine sVBSBuffer, "Set objShell = Nothing"
		AppendLine sVBSBuffer, "WScript.Quit"

		'Write the file
		Set hVBSFile = FSO.CreateTextFile(sVBSFile, True)
			hVBSFile.Write sVBSBuffer
			hVBSFile.Close
		Set hVBSFile = Nothing
		
		ConvertFile = True		'Return true
	Else
		'Not a valid registry file
		'Add error to list
		AddError "Invalid registry file: " & sFile
		ConvertFile = False		'Return false
	End If
	
	hRegFile.Close	'Close the registry file
	Set hRegFile = Nothing
End Function


Function GetHKEYValue(sHKEY)
	'Translates the HKEY value to RegWrite compatible one
	Select Case sHKEY
	Case "HKEY_CLASSES_ROOT": GetHKEYValue = "HKCR"
	Case "HKEY_CURRENT_USER": GetHKEYValue = "HKCU"
	Case "HKEY_LOCAL_MACHINE": GetHKEYValue = "HKLM"
	Case Else
		AddError "Unknown HKEY value: " & sHKEY
		GetHKEYValue = "Unknown HKEY value"
	End Select
End Function


Function ConvertLine(sRegLine) 	'Converts a registry file line into the vbscript equivalent
	Dim sLine, Result
	sLine = Trim(sRegLine)	'Remove spaces at begin and end of line
	If Len(sLine) = 0 Then
		MsgBox "ConvertLine - Len(sRegLine) = 0 - Shouldn't be here", vbCritical
		'Do nothing - blank line
	ElseIf Left(sLine, 1) = ";" Then								'*** ; comment 	 *****
		Result="'"&Mid(sLine, 2, Len(sLine))
		
	ElseIf Left(sLine, 2) = "@=" Then						'		***	@= Default Value****
		Dim l_datad	
		l_datad=Right(sLine,Len(sLine)-2)
		if Len(l_datad) >2 then 	'if not blank, check for chr(34) in data
			Dim l_datadRAW
			l_datadRAW=Mid(l_datad,2,len(l_datad)-2)	'Remove chr(34) at beginning and end of string
			If Instr(1, l_datadRAW, chr(34), vbTextCompare)>0 then 'if contains " ==> chr(34)
				l_datadRAW=Replace(l_datadRAW, """", """""")
'				l_datadRAW=Replace(l_datadRAW, "\""", "\""""")	' to try to handle "\"c:\blabla\""	=> NFG!!!
				l_datadRAW=Replace(l_datadRAW, "\"&chr(34), "\"&chr(34)&chr(34))	' to try to handle "\"c:\blabla\""	=> NFG!!!
'					AddError "value data contained "" Now fixed. was: " & sLine
				l_datad=""""&l_datadRAW&""""	'Add chr(34) back at beginning and end of string
			End if
		End if
		Result = "objShell.RegWrite """ & g_Key & "\" & "" & """, " & Right(sLine,Len(sLine)-2) & ", " & Chr(34) & "REG_SZ" & Chr(34)&" 'Default value"
		
	ElseIf Left(sLine, 2) = "[-" Then								'***    Delete KEY 	(starts with [- )	*****
		'Extract HKEY value and convert it to be vbscript' RegWrite compatible 
		'NOTE: Key names with " are valid (see paper sizes in registry)
		l_HKEY = Mid(sLine, 2, Instr(sLine, "\") - 2)
		l_HKEY=Replace(l_HKEY, "-", "")	'remove - to process
		l_LenHKEY = Len(l_HKEY)
		l_HKEY = GetHKEYValue(l_HKEY)
		l_Subkey = Mid(sLine, l_LenHKey + 3, Len(sLine) - l_LenHKEY - 3) 	'Extract subkey data
		g_Key = l_HKEY & "\" & l_SubKey			'Reconstruct new key data

		'check for " in key name	(Sanity check)
'		If Instr(1, g_Key, chr(34), vbTextCompare)>0 then 'if contains " ==> invalid Keyname!
'			msgbox g_Key&" contains "" which is invalid."&vbcrlf&"it is being removed to proceed"
'			g_Key=Replace(g_Key, """", "")
'			AddError "Key name is invalid=> fixed. was: " & sLine
'		End if
		
		'Create the key
		Result = "objShell.RegDelete """&g_Key&"\"&""""
				
	ElseIf Left(sLine, 1) = "[" Then								'***     KEY 	(starts with [ )	*****
		'Extract HKEY value and convert it to be vbscript' RegWrite compatible 
		'NOTE: Key names with " are valid (see paper sizes in registry)
		l_HKEY = Mid(sLine, 2, Instr(sLine, "\") - 2)
'		msgbox "g_long_HKEY="&g_long_HKEY
		g_long_HKEY=l_HKEY		'Needed for WMI's StdRegProv Class
		l_LenHKEY = Len(l_HKEY)
		l_HKEY = GetHKEYValue(l_HKEY)
		l_Subkey = Mid(sLine, l_LenHKey + 3, Len(sLine) - l_LenHKEY - 3)	'Extract subkey data
		g_Key = l_HKEY & "\" & l_SubKey			'Reconstruct new key data

		'check for " in key name	(Sanity check)
'		If Instr(1, g_Key, chr(34), vbTextCompare)>0 then 'if contains " ==> invalid Keyname!
'			msgbox g_Key&" contains "" which is invalid."&vbcrlf&"it is being removed to proceed"
'			g_Key=Replace(g_Key, """", "")
'			AddError "Key name is invalid=> fixed. was: " & sLine
'		End if

		'Create the key
		Result = "objShell.RegWrite """ & g_Key & "\"", """""
		
		
	ElseIf LCase(right(sLine, 2)) = ",\" AND bDoingMultiSZ=TRUE Then	'	*** Multi-SZ **** Middle of MultiSZ Value statement
		strMultiValue=sLine
		'convert ,\ to ,_	(sneaky way to process reg one line at a time)
		strMultiValue="&H"&Replace(strMultiValue, ",\", ",_")
		'convert Hex values to &H hex values
		strMultiValue=Replace(strMultiValue, ",", ",&H")
		strMultiValue=Replace(strMultiValue, ",&H_", ",_") 'Fix the ends
		Result = strMultiValue
		
	ElseIf LCase(right(sLine, 5)) = "00,00" AND bDoingMultiSZ=TRUE Then	'	*** Multi-SZ **** End of MultiSZ Value statement
		bDoingMultiSZ=False		'Were done with *this* multi line statement, setting up for next
		bDoingUnicode=False
		strMultiValue=sLine
		'convert Hex values to &H hex values
		strMultiValue="&H"&Replace(strMultiValue, ",", ",&H")
'		strMultiValue=Replace(strMultiValue, ",&H_", ",_") 'Fix the ends
		Result = strMultiValue &")"
		'	 					oReg.SetMultiStringValue HKEY_LOCAL_MACHINE,strKeyPath,strMultiValue,iValues
		Result = Result&vbCRLF&"oReg.SetMultiStringValue "&g_long_HKEY&", """&l_Subkey&""", """&g_Value&""", ArrOfValue"&vbCRLF		
		
		
	ElseIf LCase(right(sLine, 2)) = ",\" AND bDoingBINARY=TRUE Then	'		*** BINARY **** Middle of BINARY Value statement
		strBINARYValue=sLine
		'convert ,\ to ,_	(sneaky way to process reg one line at a time)
		strBINARYValue="&H"&Replace(strBINARYValue, ",\", ",_")
		'convert Hex values to &H hex values
		strBINARYValue=Replace(strBINARYValue, ",", ",&H")
		strBINARYValue=Replace(strBINARYValue, ",&H_", ",_") 'Fix the ends
		Result = strBINARYValue
		
	ElseIf LCase(right(sLine, 5)) = "00,00" AND bDoingBINARY=TRUE AND bDoingUnicode=TRUE Then	'	*** BINARY **** End of BINARY Value statement (unicode)
		bDoingBINARY=False		'Were done with *this* BINARY line statement, setting up for next
		bDoingUnicode=False
		strBINARYValue=sLine
		'convert Hex values to &H hex values
		strBINARYValue="&H"&Replace(strBINARYValue, ",", ",&H")
'		strBINARYValue=Replace(strBINARYValue, ",&H_", ",_") 'Fix the ends
		Result = strBINARYValue &")"
		'	 					oReg.SetBinaryValue HKEY_LOCAL_MACHINE,strKeyPath,BinaryValueName,iValues
		Result = Result&vbCRLF&"oReg.SetBinaryValue "&g_long_HKEY&", """&l_Subkey&""", """&g_Value&""", ArrOfValue"&vbCRLF
		
	ElseIf LCase(right(sLine, 3)) = ",00" AND bDoingBINARY=TRUE AND bDoingUnicode=False Then	'	*** BINARY **** End of BINARY Value statement (ASCII)
		bDoingBINARY=False		'Were done with *this* BINARY line statement, setting up for next
		bDoingUnicode=False
		strBINARYValue=sLine
		'convert Hex values to &H hex values
		strBINARYValue="&H"&Replace(strBINARYValue, ",", ",&H")
'		strBINARYValue=Replace(strBINARYValue, ",&H_", ",_") 'Fix the ends
		Result = strBINARYValue &")"
		'	 					oReg.SetBinaryValue HKEY_LOCAL_MACHINE,strKeyPath,BinaryValueName,iValues
		Result = Result&vbCRLF&"oReg.SetBinaryValue "&g_long_HKEY&", """&l_Subkey&""", """&g_Value&""", ArrOfValue"&vbCRLF


	ElseIf LCase(right(sLine, 2)) = ",\" AND bDoingEXPANDSZ=TRUE Then	'		*** EXPAND_SZ **** Middle of EXPAND_SZ Value statement
		strEXPANDSZValue=sLine
		'convert ,\ to ,_	(sneaky way to process reg one line at a time)
		strEXPANDSZValue="&H"&Replace(strEXPANDSZValue, ",\", ",_")
		'convert Hex values to &H hex values
		strEXPANDSZValue=Replace(strEXPANDSZValue, ",", ",&H")
		strEXPANDSZValue=Replace(strEXPANDSZValue, ",&H_", ",_") 'Fix the ends
		Result = strEXPANDSZValue


	ElseIf LCase(right(sLine, 5)) = "00,00" AND bDoingEXPANDSZ=TRUE AND bDoingUnicode=TRUE Then	'	*** EXPAND_SZ **** End of EXPAND_SZ Value statement (unicode)
		bDoingEXPANDSZ=False		'Were done with *this* EXPAND_SZ line statement, setting up for next
		bDoingUnicode=False
		strEXPANDSZValue=sLine
		'convert Hex values to &H hex values
		strEXPANDSZValue="&H"&Replace(strEXPANDSZValue, ",", ",&H")
'		strEXPANDSZValue=Replace(strEXPANDSZValue, ",&H_", ",_") 'Fix the ends
		Result = strEXPANDSZValue &")"
		'	 					oReg.SetExpandedStringValue HKEY_LOCAL_MACHINE,strKeyPath,strEXPANDSZValue,iValues
		Result = Result&vbCRLF&"oReg.SetExpandedStringValue "&g_long_HKEY&", """&l_Subkey&""", """&g_Value&""", ArrOfValue"&vbCRLF

		
	ElseIf Left(sLine, 1) = Chr(34) Then	'***   Start of Value  (line starts with " ) 	*****
		'Add Value
'		Dim l_Value 'Now g_value
		Dim l_Data
		Dim l_Comment
		'Extract value and data from sRegLine
		g_Value = Mid(sLine, 2, Instr(sLine, "=") - 3)
		l_Data = Right(sLine, Len(sLine) - Len(g_Value) - 3)
		l_Comment=""
		
		If Instr(1, g_Value, chr(34), vbTextCompare)>0 then 'if Value name contains " ==> remove it
			msgbox "Value name "&g_Value&" contains "" and will now be removed"
			g_Value=Replace(g_Value, """", "")
'			AddError "value name contained chr(34) "" Now fixed. was: " & sLine
		End if
		'Check what type of data we are converting
		If Left(l_Data, 1) = Chr(34) Then								'	***	STRING Value (starts with " )****
			if Len(l_Data) >2 then 	'if not blank
				Dim l_dataRAW
				l_dataRAW=Mid(l_Data,2,len(l_Data)-2)	'Remove chr(34) at beginning and end of string
				If Instr(1, l_dataRAW, chr(34), vbTextCompare)>0 then 'if contains " ==> chr(34)
					'msgbox l_dataRAW&" contains "" being fixed to proceed"
					l_dataRAW=Replace(l_dataRAW, """", """""")
'					AddError "value data contained "" Now fixed. was: " & sLine
					l_data=""""&l_dataRAW&""""	'Add chr(34) back at beginning and end of string
				End if
			End if
			Result = "objShell.RegWrite """ & g_Key & "\" & g_Value & """, " & l_Data & ", " & Chr(34) & "REG_SZ" & Chr(34)

		ElseIf Left(l_Data, 1) = "-" Then								'	***	Delete Value (starts with - )****
			Result = "objShell.RegDelete """ & g_Key & "\" & g_Value &""" 'Delete value"
			
		ElseIf LCase(Left(l_Data, 5)) = "dword" Then						'	*** DWORD Value****
			If Instr(1, l_Data, ";", vbTextCompare)>0 then 'if contains ; ==> Comment
				l_Comment = "	'"&Mid(l_Data, Instr(1,l_Data, ";", vbTextCompare)+1 )	' Comment is ;(+1) to end of line
				l_Data = Trim(Mid(l_Data, 1,Instr(1,l_Data, ";", vbTextCompare)-1))	' Data is start to ;
			End if
			l_Data = Right(l_Data, Len(l_Data) - 6)
			Result = "objShell.RegWrite """ & g_Key & "\" & g_Value & """, " & HexToDec(l_Data) & ", " & Chr(34) & "REG_DWORD" & Chr(34)&l_Comment

		ElseIf LCase(Left(l_Data, 7)) = "hex(7):" Then						'		*** Multi-SZ Value (Start) ****		
			strMultiValue=(right(l_Data, len(l_Data)-7))	'Get the values
			'convert ,\ to ,_	(sneaky way to process one line at a time)
			strMultiValue=Replace(strMultiValue, ",\", ",_")
			'convert Hex values to &H hex values
'			iValues = Array(&H01,&Ha2,&H10)
			strMultiValue="&H"&Replace(strMultiValue, ",", ",&H")
			strMultiValue=Replace(strMultiValue, ",&H_", ",_") 'Fix the ends
			Result="ArrOfValue = Array("&strMultiValue&"	'Building array for handling Multi-SZ Value"	'convert values into an array but don't the statement yet! (use _ )
			bDoingMultiSZ=TRUE	'
			bUsingStdRegProv=TRUE
			If LCase(right(l_Data, 5)) = "00,00" then 'if the end of the line is "00,00" => end Statement
				'						oReg.SetMultiStringValue HKEY_LOCAL_MACHINE,strKeyPath, MultiValueName,iValues
				Result = Result&vbCRLF&"oReg.SetMultiStringValue "&g_long_HKEY&", """&l_Subkey&""", """&g_Value&""", ArrOfValue"
			End if	
			
		ElseIf LCase(Left(l_Data, 8)) = "hex(03):" OR LCase(Left(l_Data, 4)) = "hex:" Then	'	*** BINARY Value (start) ****			
			If LCase(Left(l_Data, 8)) = "hex(03):" then 
				strBINARYValue=(right(l_Data, len(l_Data)-8))	'Get the Unicode values
				bDoingUnicode=True
			Else
				strBINARYValue=(right(l_Data, len(l_Data)-4))	'Get the ASCII values
				bDoingUnicode=False 'just in case
			End if
			'convert ,\ to ,_	(sneaky way to process one line at a time)
			strBINARYValue=Replace(strBINARYValue, ",\", ",_")
			'convert Hex values to &H hex values
'			iValues = Array(&H01,&Ha2,&H10)
			strBINARYValue="&H"&Replace(strBINARYValue, ",", ",&H")
			strBINARYValue=Replace(strBINARYValue, ",&H_", ",_") 'Fix the ends
			Result="ArrOfValue = Array("&strBINARYValue&"	'Building array for handling BINARY Value"	'convert values into an array but don't finish the statement yet! (use _ )
			bDoingBINARY=TRUE	'
			bUsingStdRegProv=TRUE
			If LCase(right(l_Data, 5)) = "00,00" then 'if the end of the line is "00,00" => end Statement
							'			oReg.SetBinaryValue HKEY_LOCAL_MACHINE,strKeyPath,BinaryValueName,iValues
				Result = Result&vbCRLF&"oReg.SetBinaryValue "&g_long_HKEY&", """&l_Subkey&""", """&g_Value&""", ArrOfValue"
			End if	
			
		ElseIf LCase(Left(l_Data, 7)) = "hex(2):" Then	'	*** EXPAND_SZ Value (start) ****			
'			If LCase(Left(l_Data, 7)) = "hex(2):" then 
				strEXPANDSZValue=(right(l_Data, len(l_Data)-7))	'Get the Unicode values
				bDoingUnicode=True
'			Else
'				strEXPANDSZValue=(right(l_Data, len(l_Data)-4))	'Get the ASCII values
'				bDoingUnicode=False 'just in case
'			End if
			'convert ,\ to ,_	(sneaky way to process one line at a time)
			strEXPANDSZValue=Replace(strEXPANDSZValue, ",\", ",_")
			'convert Hex values to &H hex values
'			iValues = Array(&H01,&Ha2,&H10)
			strEXPANDSZValue="&H"&Replace(strEXPANDSZValue, ",", ",&H")
			strEXPANDSZValue=Replace(strEXPANDSZValue, ",&H_", ",_") 'Fix the ends
			Result="ArrOfValue = Array("&strEXPANDSZValue&"	'Building array for handling EXPAND_SZ Value"	'convert values into an array but don't finish the statement yet! (use _ )
			bDoingEXPANDSZ=TRUE	'
			bUsingStdRegProv=TRUE
			If LCase(right(l_Data, 5)) = "00,00" then 'if the end of the line is "00,00" => end Statement
							'			oReg.SetBinaryValue HKEY_LOCAL_MACHINE,strKeyPath,strEXPANDSZValue,iValues
				Result = Result&vbCRLF&"oReg.SetExpandedStringValue "&g_long_HKEY&", """&l_Subkey&""", """&g_Value&""", ArrOfValue"
			End if	
		Else						'***	Unknown value type
			AddError "Unknown registry value type: " & sLine
			Result = "'Unknown value type" & sLine
		End If
	
		
	Else
		'Unknown registry line value
		AddError "Unknown registry line value: " & sRegLine
		Result = "'Unknown registry line Value" & sRegLine
	End If
	ConvertLine = Result
End Function



Function HexToDec(sHex)
	'Converts a hexadecimal string into a decimal
'	dim strNoKeyError
'	On Error Resume Next	'Disable error checking
	HexToDec = CStr(CLng("&H" & sHex))
'	strNoKeyError = Err.Description
'	If NOT strNoKeyError="" then
'		msgbox "error description="&strNoKeyError&vbcrlf&sRegLine
'	End if
'	Err.Clear
'	On Error Goto 0		're-enable error checking
End Function


Sub AddError(sError)
	AppendLine g_Err, "[" & g_CurrentFile & "] - " & sError
End Sub

Sub AppendStr(sVar, sStr)
	'Appends sStr to sVar.  Just cleaner than appending with "&" all the time
	sVar = sVar & sStr
End Sub

Sub AppendLine(sVar, sStr)
	'Appends sStr to sVar and adds a vbCrLf
	AppendStr sVar, sStr & vbCrLf
End Sub

Sub PrependStr(sVar, sStr)
	'Prepends sStr to sVar.  Just cleaner than appending with "&" all the time
	sVar = sStr & sVar
End Sub

Sub PrependLine(sVar, sStr)
	'Prepends sStr to sVar and adds a vbCrLf
	PrependStr sVar, sStr & vbCrLf
End Sub
