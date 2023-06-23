
class UISettingsData {
	__New(ui := Gui()) {
		this.gui := ui
		this.window := {
			x: 1940,
			y: 460,
			width: 500,
			height: 200,

			backgroundColor: '181818',

			monitorIndex: 2,
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
			win.height += win.toolbarHeight
			if (win.screenPosition == "center") {
				win.x := (screenMatrix.width / 2) - (win.width / 2)
				win.y := (screenMatrix.height / 2) - (win.height / 2)
			} else if (win.screenPosition == "topLeft") {
				win.x := (win.monitorIndex > 1) ? (screenMatrix.width / 2) : 0
				win.y := 0
			} else if (win.screenPosition == "topRight") {
				win.x := screenMatrix.width - win.width
				win.y := 0
			} else if (win.screenPosition == "bottomLeft") {
				win.x := (win.monitorIndex > 1) ? (screenMatrix.width / 2) : 0
				win.y := screenMatrix.height - win.height
			} else if (win.screenPosition == "bottomRight") {
				win.x := screenMatrix.width - win.width
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
	setWindowSize(width, height) {
		this.window.width := width
		this.window.height := height
	}

	setWindowPosition(x, y) {
		this.window.x := x
		this.window.y := y
	}
	;#endregion

	applySettings() {
		this.gui.BackColor := this.window.backgroundColor
		this.gui.Move(this.window.x, this.window.y, this.window.width, this.window.height)
	}

	showWindow() {
		focus := WinGetClass("A") ;? Get the class of the window that is currently active

		this.Validate()
		this.applySettings()
		this.gui.Show(this.getWindowMatrix())

		if WinExist('ahk_class' focus) ;? Restore focus to the window that was active before
			WinActivate
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