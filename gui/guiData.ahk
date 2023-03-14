
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
			screenMetrics := GetScreenMetrics(this.window.monitorIndex)
			screenMetrics.height -= 80 ; Remove taskbar height
			win := this.window
			win.height += win.toolbarHeight
			if (win.screenPosition == "Centered") {
				win.x := (screenMetrics.width / 2) - (win.width / 2)
				win.y := (screenMetrics.height / 2) - (win.height / 2)
			} else if (win.screenPosition == "TopLeft") {
				win.x := (win.monitorIndex > 1) ? (screenMetrics.width / 2) : 0
				win.y := 0
			} else if (win.screenPosition == "TopRight") {
				win.x := screenMetrics.width - win.width
				win.y := 0
			} else if (win.screenPosition == "BottomLeft") {
				win.x := (win.monitorIndex > 1) ? (screenMetrics.width / 2) : 0
				win.y := screenMetrics.height - win.height
			} else if (win.screenPosition == "BottomRight") {
				win.x := screenMetrics.width - win.width
				win.y := screenMetrics.height - win.height
			}
		}
	}

	getWindowMetrics() {
		return "x" this.window.x " y" this.window.y " w" this.window.width " h" this.window.height
	}
}

GetScreenMetrics(monitor) {
	metrics := {}
	metrics.width := A_ScreenWidth * monitor
	metrics.height := A_ScreenHeight
	metrics.aspectRatio := metrics.width / metrics.height

	; OutputDebug("Screen metrics: " metrics.width "x" metrics.height " (" metrics.aspectRatio ")")

	return metrics
}