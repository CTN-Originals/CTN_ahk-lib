; This file is for testing perposes
#Include import.ahk

#SingleInstance Force
#Warn All, Off
#ErrorStdOut 'UTF-8'
OnError ErrorHandler
Persistent(true)

try FileAppend('', 'x/y/z/test.txt')
catch Error as e {
	ErrorHandler(e, false)
}
try Paradox()
catch Error as e {
	ErrorHandler(e, false)
}

Global ui := Gui()
Global uiSettings := UISettingsData()
ui.BackColor := '181818'

MyBtn := ui.AddButton("x10 y10 w100 h30", 'Button1')
MyBtn.OnEvent("Click", MyButtonFunc)
; MsgBox(getWinButton.Text)
; fn := CallbackCreate(MyButtonFunc)
OutputDebug(uiSettings.getWindowMatrix())

orignalFocusedWin := WinGetID("A") ; Get the ID of the active window
; ui.Show(uiSettings.getWindowMatrix())
WinActivate(orignalFocusedWin) ; Activate the original window
return

MyButtonFunc(GuiEvent*) {
	OutputDebug(GuiEvent[1].Text)
}