
class UISettingsData {
	__New(ui := Gui()) {
		this.gui := ui
		this.title := ''
		this.returnFocus := !A_IsCompiled
		this.showAfterReturnedFocus := (this.returnFocus && !A_IsCompiled)
		this.window := {
			x: 1940,
			y: 460,
			width: 500,
			height: 200,
			innerHeight: 230,
			margin: 10,
			gap: 5,

			backgroundColor: '181818',

			monitorIndex: (A_IsCompiled) ? 1 : 2,
			screenPosition: "bottomLeft", ;* unset - center - topLeft - topRight - bottomLeft - bottomRight
			toolbarHeight: 30 ;? the height of the toolbar (if any) in pixels (the top bar with the close button)
		}

		this.Init()
	}

	Init() {
		this.Validate()
	}

	Validate() {
		if (this.window.screenPosition != "unset") {
			screenMatrix := GetScreenMatrix(this.window.monitorIndex)
			screenMatrix.height -= 80 ; Remove taskbar height
			win := this.window
			win.innerHeight := win.height
			win.height += win.toolbarHeight
			if (win.screenPosition == "center") {
				win.x := (screenMatrix.width / 2) - (win.width / 2)
				win.y := (screenMatrix.height / 2) - (win.height / 2)
			} else if (win.screenPosition == "topLeft") {
				win.x := (win.monitorIndex > 1) ? (screenMatrix.width / 2) : 0
				win.y := 0
			} else if (win.screenPosition == "topRight") {
				win.x := screenMatrix.width - win.width - 15
				win.y := 0
			} else if (win.screenPosition == "bottomLeft") {
				win.x := (win.monitorIndex > 1) ? (screenMatrix.width / 2) : 0
				win.y := screenMatrix.height - win.height
			} else if (win.screenPosition == "bottomRight") {
				win.x := screenMatrix.width - win.width - 15
				win.y := screenMatrix.height - win.height
			}
		}
	}

	;#region Getters
	getWindowMatrix() {
		return "x" this.window.x " y" this.window.y " w" this.window.width " h" this.window.height
	}
	;#endregion

	;#region Setters
	setWindowPosition(x, y, apply := false) {
		this.window.x := x
		this.window.y := y
		if (apply) {
			this.gui.Move(this.window.x, this.window.y)
		}
	}
	setWindowSize(width, height, apply := false) {
		this.window.width := width
		this.window.height := height
		if (apply) {
			this.gui.Move(,, this.window.width, this.window.height)
		}
	}
	setWindowRect(x, y, width, height, apply := false) {
		this.window.x := x
		this.window.y := y
		this.window.width := width
		this.window.height := height
		if (apply) {
			this.gui.Move(this.window.x, this.window.y, this.window.width, this.window.height)
		}
	}
	;#endregion

	applySettings() {
		this.gui.BackColor := this.window.backgroundColor
		this.gui.Move(this.window.x, this.window.y, this.window.width, this.window.height)
	}

	showWindow() {
		focus := WinGetID("A") ;? Get the class of the window that is currently active

		this.Validate()
		this.applySettings()
		this.gui.Show(this.getWindowMatrix())
		this.gui.title := (this.title) ? this.title : A_ScriptName

		;? Restore focus to the window that was active before
		;* Normally useful for testing/creating gui's to return focus to your IDE
		;! Not recommended after releasing a program to the public
		;! You can put this in an if statement with A_IsCompiled (if (A_IsCompiled) { ui.returnFocus := false })
		if (this.returnFocus && WinExist(focus)) { 
			WinActivate(focus)

			;? When focus is returned, show the gui window once again but dont steal focus from the original window
			;* This is useful when a program (like your IDE) is covering the gui's position
			if (this.showAfterReturnedFocus) {
				this.gui.Opt('+AlwaysOnTop')
				this.gui.Opt('-AlwaysOnTop')
			}
		}
	}
}

GetScreenMatrix(monitor) {
	matrix := {}
	matrix.width := A_ScreenWidth * monitor
	matrix.height := A_ScreenHeight
	matrix.aspectRatio := matrix.width / matrix.height

	; OutputDebug("Screen matrix: " matrix.width "x" matrix.height " (" matrix.aspectRatio ")")

	return matrix
}