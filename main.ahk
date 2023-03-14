#SingleInstance Force
#Warn All, Off
#ErrorStdOut 'UTF-8'
OnError ErrorHandler
Persistent(true)

#Include modules/onLoad.ahk
#Include modules/errorHandler.ahk
#Include modules/utils/import.ahk

#Include gui/guiData.ahk
#Include modules/debug/console/console.ahk

Global ui := Gui()
Global uiSettings := UISettingsData()
ui.BackColor := '181818'

MyBtn := ui.AddButton("x10 y10 w100 h30", 'Button1')
MyBtn.OnEvent("Click", MyButtonFunc)
; MsgBox(getWinButton.Text)
; fn := CallbackCreate(MyButtonFunc)
; MyBtn.OnEvent("Click", MyButtonFunc)
; OutputDebug(uiSettings.getWindowMetrics())

; orignalFocusedWin := WinGetID("A") ; Get the ID of the active window
; ui.Show(uiSettings.getWindowMetrics())
; WinActivate(orignalFocusedWin) ; Activate the original window
return


MyButtonFunc(GuiEvent*) {
	OutputDebug(GuiEvent[1].Text)
}

