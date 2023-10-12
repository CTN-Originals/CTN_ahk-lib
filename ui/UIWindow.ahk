class UIWindow {
	__New(x := 10, y := 10, width := 500, height := 250) {
		this.x := x
		this.y := y
		this.width := width
		this.height := height
		
		this.hwnd := 0
		this.center := true

		this.settings := UIWindowSettings()
	}

	/** 
	 * @returns This Hwnd
	*/
	__Get() {
		return this.hwnd
	}

	/** 
	 * @param {Gui} targetGui The gui to show
	 * @param {String} title The title of the gui
	*/
	show(targetGui, title := A_ScriptName) {
		focus := WinGetID("A") ;? Get the class of the window that is currently active

		;TODO if WinExists this._hwnd to prevent opening multiple windows
		targetGui.Title := title
		targetGui.Show(getFlags(this))

		this.hwnd := targetGui.Hwnd

		;? Restore focus to the window that was active before
		;* Normally useful for testing/creating gui's to return focus to your IDE
		;! Not recommended after releasing a program to the public
		;! Default value: returnFocus := !A_IsCompiled | onTopReturnFocus := (returnFocus && !A_IsCompiled)
		if (this.settings.returnFocus && WinExist(focus)) { 
			WinActivate(focus)

			;? When focus is returned, show the gui window once again but dont steal focus from the original window
			;* This is useful when a program (like your IDE) is covering the gui's position
			if (this.settings.onTopReturnFocus) {
				targetGui.Opt('+AlwaysOnTop')
				targetGui.Opt('-AlwaysOnTop')
			}
		}
	}
}
class UIWindowSettings {
	__New() {
		this.returnFocus := !A_IsCompiled
		this.onTopReturnFocus := (this.returnFocus && !A_IsCompiled)
	}
}