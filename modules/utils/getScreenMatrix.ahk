; MonitorCount := MonitorGetCount()
; MonitorPrimary := MonitorGetPrimary()
; MsgBox "Monitor Count:`t" MonitorCount "`nPrimary Monitor:`t" MonitorPrimary
; Loop MonitorCount
; {
;     MonitorGet A_Index, &L, &T, &R, &B
;     MonitorGetWorkArea A_Index, &WL, &WT, &WR, &WB
;     MsgBox
;     (
;         "Monitor:`t#" A_Index "
;         Name:`t" MonitorGetName(A_Index) "
;         Left:`t" L " (" WL " work)
;         Top:`t" T " (" WT " work)
;         Right:`t" R " (" WR " work)
;         Bottom:`t" B " (" WB " work)"
;     )
; }

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
			return this
		}
	}
}

; class systemMonitorData extends SystemMonitorDataClass {
; }
Global systemMonitorData := SystemMonitorDataClass()