;#Requires AutoHotkey v1.1.37.01
 
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force ; Makes it so only one script instance is running at any time and skips prompt.
#WinActivateForce  ; Enable activating windows forcefully.

!Enter:: ; Activates snipping tool in New Snip mode.
{
	KeyWait, Enter 
	Keywait, Alt
	If WinExist("ahk_class Microsoft-Windows-SnipperToolbar")
	{
		WinGet, State, MinMax
		If (State = -1)
		{	
			WinRestore
			WinWaitActive, ahk_class Microsoft-Windows-SnipperToolbar
			Send, ^n
		}
		else
		{
			WinActivate
			WinWaitActive, ahk_class Microsoft-Windows-SnipperToolbar
			Send, Esc
			Send, ^n
		}
	}
	else If WinExist("ahk_class Microsoft-Windows-SnipperEditor")
	{
		WinGet, State, MinMax
		If (State = -1)
		{
			Run, snippingtool.exe
			If (SubStr(A_OSVersion,1,2)=10)
			{
				WinWaitActive, ahk_class Microsoft-Windows-SnipperEditor
				Send, ^n
			}
		}
		else
		{
			Run, snippingtool.exe
			If (SubStr(A_OSVersion,1,2)=10)
			{
				WinWaitActive, ahk_class Microsoft-Windows-SnipperEditor
				Send, Esc
				Send, ^n
			}
		}
	}
	else
	{
		Run, snippingtool.exe
		If (SubStr(A_OSVersion,1,2)=10)
		{
			WinWaitActive, ahk_class Microsoft-Windows-SnipperToolbar
			Send, ^n
		}
	}

	Return
}

#IfWinActive ahk_exe PPSSPPWindows64.exe
	!Enter::
		KeyWait, Enter 
		Keywait, Alt
		CoordMode, Mouse, Screen  ; Sets coordinate mode to base on screen.
		If WinExist("ahk_class Microsoft-Windows-SnipperToolbar")
		{
			WinGet, State, MinMax
			If (State = -1)
			{	
				WinRestore
				WinWaitActive, ahk_class Microsoft-Windows-SnipperToolbar
				PpssppProcedures()
			}
			else
			{
				WinActivate
				WinWaitActive, ahk_class Microsoft-Windows-SnipperToolbar
				Send, Esc
				PpssppProcedures()
			}
		}
		else If WinExist("ahk_class Microsoft-Windows-SnipperEditor")
		{
			WinGet, State, MinMax
			If (State = -1)
			{
				Run, snippingtool.exe
				If (SubStr(A_OSVersion,1,2)=10)
				{
					WinWaitActive, ahk_class Microsoft-Windows-SnipperEditor
					PpssppProcedures()
				}
			}
			else
			{
				Run, snippingtool.exe
				If (SubStr(A_OSVersion,1,2)=10)
				{
					WinWaitActive, ahk_class Microsoft-Windows-SnipperEditor
					Send, Esc
					PpssppProcedures()
				}
			}
		}
		else
		{
			Run, snippingtool.exe
			If (SubStr(A_OSVersion,1,2)=10)
			{
				WinWaitActive, ahk_class Microsoft-Windows-SnipperToolbar
				PpssppProcedures()
			}
		}

		Return


#IfWinActive ahk_class #32770
	;The 'Up' of hotkeys can also be omitted, but for clarity purposes, they are left there.
	^+p Up::  ; triggers programming life
		KeyWait, Ctrl
		KeyWait, Shift
		KeyWait, p
		path := "C:\Users\Admin\Desktop\Programming Life\"
		NavigateTo(path, True)
		Return
	^+l Up::  ;triggers language cottage 
		KeyWait, Ctrl
		KeyWait, Shift
		KeyWait, o
		path := "C:\Users\Admin\Desktop\Language Cottage\"
		pathTail := "\oripic"
		NavigateTo(path, True, pathTail)
		Return
	^+m Up::  ;triggers music square
		KeyWait, Ctrl
		KeyWait, Shift
		KeyWait, m
		path := "C:\Users\Admin\Desktop\Music Square\" 
		NavigateTo(path, True)
		Return
	^+i Up::  ;triggers life
		KeyWait, Ctrl
		KeyWait, Shift
		KeyWait, i
		path := "C:\Users\Admin\Desktop\Life\" 
		NavigateTo(path, True)
		Return
	^+b Up::  ;triggers bookshelf
		KeyWait, Ctrl
		KeyWait, Shift
		KeyWait, i
		path := "C:\Users\Admin\Desktop\Bookshelf\" 
		NavigateTo(path, True)
		Return
	^+o Up::  ;trigger precious moments
		KeyWait, Ctrl
		KeyWait, Shift
		KeyWait, o
		path := "C:\Users\Admin\Desktop\Precious Moments" 
		NavigateTo(path, False)
		datetimeNow := A_NOW ;auto set today's partial file name
		FormatTime, strDateFolder, datetimeNow, yyyy_MM_dd
		Send, %strDateFolder%
		Send, _
		Return
	^+t::  ;triggers utp life
		KeyWait, Ctrl
		KeyWait, Shift
		KeyWait, t
		path := "C:\Users\Admin\Desktop\utp degree\Utp Life\" 
		NavigateTo(path, True)
		Return

#IfWinActive ahk_class Microsoft-Windows-SnipperEditor
	Enter Up:: ;closes snipper editor (it closes the editor after saved in save dialog by mistake)
		KeyWait, Enter
		Send, !{F4} 
		Send, {Enter} ;to unglitch ahk waiting for an Enter key input.
		Return


;functions block
NavigateTo(pathNew, appendDate, newPathTail := "")
{
	path := ""
	If (appendDate)
	{
		datetimeNow := A_NOW
		FormatTime, strDateFolder, datetimeNow, yyyy_MM_dd
		path := pathNew . strDateFolder . newPathTail
	}
	else
	{
		path := pathNew
	}
	Send, ^l
	Send, ^a
	SetInputLanguageToEnglishMalaysia()
	Send, %path%
	Send, {Enter}

	; Select last file in folder.
	Send, {Tab 4}  
	Send, {End}

	; Go to file name input field.
	Send, !t
	ResetKeyboard()
	Send, !n
}

PpssppProcedures()
{
	Send, ^n
	WinWait, ahk_class Microsoft-Windows-SnipperCaptureForm
	MouseClickDrag, Left, 0, 0, 1365, 767, 0
	WinWaitActive, ahk_class Microsoft-Windows-SnipperEditor,,2
	If (WinExist(ahk_class Microsoft-Windows-SnipperEditor) == 0)
	{
		Return
	}
	Send, ^s
	MouseMove,680, 380, 0
	Sleep, 1000

	; Select last file in folder.
	Send, ^l
	Send, {Tab 4}  
	Send, {End}
	
	; Go to file name input field.
	Send, !t
	ResetKeyboard()
	Send, !n
	
	SetInputLanguageToJapanese()
}

SetInputLanguageToEnglishMalaysia()
{
	languageId := "0x4409"
    ControlGetFocus, focusControl
    PostMessage, 0x0050, 0, %languageId%, %focusControl%
}

SetInputLanguageToJapanese()
{
	languageId := "1041"
	SetKeyboardLanguage(languageId)
}

ResetKeyboard()
{
	Send, {LShift}
	Send, {LCtrl}
	Send, {LAlt}
	Send, {RShift}
	Send, {RCtrl}
	Send, {RAlt}
}

SetKeyboardLanguage(LocaleID)
{
	Static SPI_SETDEFAULTINPUTLANG := 0x005A, SPIF_SENDWININICHANGE := 2	
	Lan := DllCall("LoadKeyboardLayout", "Str", Format("{:08x}", LocaleID), "Int", 0)
	VarSetCapacity(binaryLocaleID, 4, 0)
	NumPut(LocaleID, binaryLocaleID)
	DllCall("SystemParametersInfo", "UInt", SPI_SETDEFAULTINPUTLANG, "UInt", 0, "UPtr", &binaryLocaleID, "UInt", SPIF_SENDWININICHANGE)	
	WinGet, windows, List
	Loop % windows
    {
		PostMessage 0x50, 0, % Lan, , % "ahk_id " windows%A_Index%
	}
}