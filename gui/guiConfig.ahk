
class UISettingsData {
	__New() {
		this.window := {
			x: 1940,
			y: 460,
			width: 500,
			height: 200,

			monitorIndex: 2,
			screenPosition: "BottomLeft", ; Unset - Centered - TopLeft - TopRight - BottomLeft - BottomRight
			toolbarHeight: 30
		}

		this.Init()
	}

	Init() {
		if (this.window.screenPosition != "Unset") {
			screenMatrix := GetScreenMatrix(this.window.monitorIndex)
			screenMatrix.height -= 80 ; Remove taskbar height
			win := this.window
			win.height += win.toolbarHeight
			if (win.screenPosition == "Centered") {
				win.x := (screenMatrix.width / 2) - (win.width / 2)
				win.y := (screenMatrix.height / 2) - (win.height / 2)
			} else if (win.screenPosition == "TopLeft") {
				win.x := (win.monitorIndex > 1) ? (screenMatrix.width / 2) : 0
				win.y := 0
			} else if (win.screenPosition == "TopRight") {
				win.x := screenMatrix.width - win.width
				win.y := 0
			} else if (win.screenPosition == "BottomLeft") {
				win.x := (win.monitorIndex > 1) ? (screenMatrix.width / 2) : 0
				win.y := screenMatrix.height - win.height
			} else if (win.screenPosition == "BottomRight") {
				win.x := screenMatrix.width - win.width
				win.y := screenMatrix.height - win.height
			}
		}
	}

	getWindowMatrix() {
		return "x" this.window.x " y" this.window.y " w" this.window.width " h" this.window.height
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