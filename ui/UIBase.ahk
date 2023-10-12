#Requires AutoHotkey v2.0

#Include UIWindow.ahk
#Include UIElementBase.ahk

class UIBase {
	__New() {
		this.name := A_ScriptName
		this.instance := [UIInstance()]
	}
	
	;#region getters
	getInst(index := 1) {
		if (index > this.instance.Length) {
			return  this.instance[1]
		}
		return this.instance[index]
	}
	;#endregion
	
	;? Shows the main UI window by default
	show(index := 1) => this.getInst(index).show()
}

class UIInstance {
	__New() {
		this.title := A_ScriptName
		this.gui := Gui() ;? the built-in gui object from ahk2 
		this.window := UIWindow()
		this.elements := UIElementBase()
	}

	show() => this.window.show(this.gui, this.title)
}


getFlags(obj) {
	out := []
	keys := ObjectUtilities.keys(obj)
	if (!obj.flagDictionary) {
		throw 'obj does not have a field called "flagDictionary"'
	}
	flagKeys := ObjectUtilities.keys(obj.flagDictionary)

	for key in keys {
		if (ArrayUtilities.indexOf(flagKeys, key) == -1 || obj.%key% == 0) {
			continue
		}
		out.Push(obj.flagDictionary.%key% obj.%key%)
	}

	return ArrayUtilities.join(out, ' ')
}