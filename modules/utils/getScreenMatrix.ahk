class SystemMonitorDataClass {
	__New() {
		this.MonitorCount := MonitorGetCount()
		this.MonitorPrimary := MonitorGetPrimary()
		this.MonitorData := []
		Loop this.MonitorCount {
			MonitorGet A_Index, &L, &T, &R, &B
			MonitorGetWorkArea A_Index, &WL, &WT, &WR, &WB
			data := {
				name: MonitorGetName(A_Index),
				index: A_Index,
				rect: {
					x: L,
					y: T,
					width: R - L,
					height: B - T,
				},
				workRect: {
					x: WL,
					y: WT,
					width: WR - WL,
					height: WB - WT,
				},
				left: L,
				top: T,
				right: R,
				bottom: B,
				workLeft: WL,
				workTop: WT,
				workRight: WR,
				workBottom: WB,
			}

			this.MonitorData.Push(data)
		}
	}
	data {
		get {
			return this.MonitorData
		}
	}
	GetDataByMonitorIndex(index) {
		Loop this.MonitorData.length {
			if (this.MonitorData[A_Index].index == index) {
				return this.MonitorData[A_Index]
			}
		}
	}
}

class systemMonitorData extends SystemMonitorDataClass {
}

; #Include <utils\import>
; console.log(SystemMonitorData())
; Global SystemMonitorData := SystemMonitorDataClass