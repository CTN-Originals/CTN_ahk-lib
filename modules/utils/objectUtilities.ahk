
/** 
 * A collection of utilities for working with objects
 * - `isObject` - Returns true if the object is an object, false otherwise
 * - `hasKey` - Returns the value of the key if it exists, false otherwise
 * - `keys` - Returns an array of keys from the object
 * - `values` - Returns an array of values from the object
*/
class ObjectUtilities {
	; static _recursionStorage := []
	__Init() {
		; OutputDebug('-------- INIT --------  `n')
		;? The current recursion storage
		this._recursionStorage := []
		;? The previous recursion storages that wereclear : [[storage1], [storage2]]
		this._recursionStorageHistory := [] 
	}

	RecursionStorage {
		get {
			OutputDebug('[OBJECT] get storage | Size: ' this._recursionStorage.Length '`n')
			return this._recursionStorage
		}
		set {
			OutputDebug('[OBJECT] set storage | Size: ' this._recursionStorage.Length ' + 1' '`n')
			if (Value == 'CLEAR') {
				OutputDebug('---- [OBJECT] Clearing RecursionStorage ---- `n')
				this.RecursionStorageHistory := this._recursionStorage
				this._recursionStorage := []
			}
			else {
				this._recursionStorage.Push(Value)
			}
		}
	}

	RecursionStorageHistory {
		get {
			; OutputDebug('[History] get storage | Size: ' this._recursionStorageHistory.Length '`n')
			return this._recursionStorageHistory
		}
		set {
			; OutputDebug('[History] set storage | Size: ' this._recursionStorageHistory.Length ' + 1' '`n')
			this._recursionStorageHistory.Push(Value)
			if (this._recursionStorageHistory.Length > 5) {
				; OutputDebug('[History] remove storage | Size: ' this._recursionStorageHistory.Length ' - 1' '`n')
				return this._recursionStorageHistory.RemoveAt(1)
			}
		}
	}

	/** 
	 * @param {Object} obj The object to stringify
	 * @param {Number} indent The number of indents to use
	 * @param {String} indentString The string to use for indents
	 * @param {Boolean} isValue Is this object a value iside another object?
	 * @returns {String} A string representation of the object
	*/
	stringify(obj, indent := 0, indentString := "  ", isValue := false, initialCall := true) {
		
		recursionDetected := this._checkRecursion(obj) ;? check for a recursion
		if (recursionDetected) {
			if (initialCall) {
				;? Clear the list to avoid the recersion detection miss-fire due to back-logging
				this.RecursionStorage := 'CLEAR' 
			}
			return '{ <recursion> }'
		}

		if (!this.isObject(obj)) {
			if (initialCall) {
				this.RecursionStorage := 'CLEAR' 
			}
			return ''
		}

		out := []
		if (this.keys(obj).Length > 0) {
			if (!isValue) {
				out.Push(StrUtils.repeat(indentString, indent) "{`n")
			}
			else {
				out.Push("{`n")
			}
		}
		else {
			if (initialCall) {
				this.RecursionStorage := 'CLEAR' 
			}
			return '{ }'
		}

		keys := this.keys(obj)
		
		for k, v in keys {
			line := ''
			key := keys[k]
			value := obj.%key%
			line .= StrUtils.repeat(indentString, indent + 1) key ": "

			if (recursionDetected) {
				line .= '{ <recursion> }'
			}
			else if (Type(value) == 'Gui') {
				line .= this.stringify(this.getGuiObject(value), indent + 1, indentString, true, false)
			}
			else if (ObjUtils.isObject(value)) {
				line .= this.stringify(
					value,
					indent + 1,
					indentString,
					!!(value.Base.__Class),
					false
				)
			}
			else if (ArrayUtilities.isArray(value)) {
				if (ArrayUtilities._checkRecursion(value)) {
					line .= '[{ <recursion> }]'
				}
				else {
					line .= ArrayUtilities.stringify(value, indent + 1, indentString)
				}
			}
			else {
				line .= value
			}

			if (this.keys(obj)[this.keys(obj).Length] != key) { ;? Check if this is the last key of the object
				line .= ",`n"
			}
			else {
				line .= "`n"
			}
			out.Push(line)
		}
		out.Push(StrUtils.repeat(indentString, indent) "}")

		if (initialCall) {
			;? Clear the list to avoid the recersion detection miss-fire due to back-logging
			this.RecursionStorage := 'CLEAR' 
		}
		return ArrayUtilities.join(out, '')
	}

	_checkRecursion(obj) {
		
		loop(this.RecursionStorage.Length) {
			i := (this.RecursionStorage.length - 0) - A_Index
			if (i < 1) {
				continue
			}
			target := this.RecursionStorage[i]
			; console.log(Type(obj) ' - ' Type(target))
			if (obj == target) {
				;! RECURSION
				console.log('[OBJECT] ! RECURSION !')
				return true
			}
		}
		this.RecursionStorage := obj

		;TODO loop thru the recursion history and check for duplicates
		
		return false
	}

	; static recursionExeptions := [
	; 	"Object",
	; 	"Array"
	; ]
	/** 
	 * @param {Object} obj The object to check
	 * @returns {Boolean} True if the object is an object, false otherwise
	*/
	isObject(obj) {
		value := false
		try value := !!(obj.OwnProps()) 
		catch Error as err{
			return false
		}
		return (value && Type(obj) != "Array")
	}

	/** 
	 * @param {Object} obj The object to retrieve the values from
	 * @param {String} key The key to check for
	 * @returns {`Any`} The value of the key if it exists, false otherwise
	*/
	hasKey(obj, key) {
		if (!this.isObject(obj)) {
			return false
		}
		for k, v in obj.OwnProps() {
			if (k == key) {
				return obj.%k%
			}
		}
		return false
	}

	/** 
	 * @param {Object} obj The object to retrieve the keys from
	 * @returns {Array} An array of keys from the object
	*/
	keys(obj) {
		if (!this.isObject(obj)) {
			return []
		}
		out := []
		keys := obj.OwnProps()
		for key, v in keys {
			out.Push(key)
		}
		return out
	}

	/** 
	 * @param {Object} obj The object to retrieve the values from
	 * @returns {Array} An array of values from the object
	*/
	values(obj) {
		out := []
		for k in obj.OwnProps() {
			out.Push(obj.%k%)
		}
		return out
	}

	/** 
	 * @param {Object} obj The Primary object
	 * @param {Object} merger The object to merge into the primary object
	*/
	merge(obj, merger, overridePrimary := false) {
		if (!this.isObject(obj)) {
			throw Error('Param is not of type Object', ObjectUtilities.merge, 'obj')
			return obj
		}
		if (!this.isObject(merger)) {
			throw Error('Param is not of type Object', ObjectUtilities.merge, 'merger')
			return obj
		}

		for key in merger.OwnProps() {
			if (this.hasKey(obj, key) && !overridePrimary) {
				continue
			}
			obj.%key% := merger.%key%
		}

		return obj
	}

	/** 
	 * @param {Gui} g the gui
	 * @returns {object} an object that can be enumerated (so just a normal object)
	*/
	getGuiObject(g) {
		return {
			Title: g.Title,
			Hwnd: g.Hwnd
		}
	}
}

/** 
 * A collection of utilities for working with objects
 * - `isObject` - Returns true if the object is an object, false otherwise
 * - `keys` - Returns an array of keys from the object
 * - `hasKey` - Returns the value of the key if it exists, false otherwise
 * - `values` - Returns an array of values from the object
*/
class ObjUtils extends ObjectUtilities {
}

ObjectUtilities.Base := ObjectUtilities()

; OutputDebug(ObjectUtilities.keys({a: 1, b: 2, c: 3})[2] '`n')