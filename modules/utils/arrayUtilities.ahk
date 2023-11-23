/** 
 * A collection of utilities for working with arrays
 * - `isArray` - Returns true if the object is an object, false otherwise
 * - `indexOf` - Returns the index of the item in the array, or -1 if not found
 * - `join` - Joins the array together with the specified separator
 * - `cleanUp` - Removes empty items from the array
 * - `contains` - Returns true if the item is in the array, false otherwise
*/
class ArrayUtilities {
	__Init() {
		this._recursionStorage := []
	}

	RecursionStorage {
		get {
			; OutputDebug('[ARRAY]  get storage | Size: ' this._recursionStorage.Length '`n')
			return this._recursionStorage
		}
		set {
			; OutputDebug('[ARRAY]  set storage | Size: ' this._recursionStorage.Length ' + 1' '`n')
			if (Value == 'CLEAR') {
				; OutputDebug('---- [ARRAY]  Clearing RecursionStorage ---- `n')
				this._recursionStorage := []
			}
			else {
				this._recursionStorage.Push(Value)
			}
		}
	}

	;! The recursion storage has a recursion inside of itself that its not detecting
	;! arr [item1, item2, item3, item4: [item1, item2, item3, item4: [and so on]]]
	_checkRecursion(arr) {
		
		loop(this.RecursionStorage.Length) {
			i := (this.RecursionStorage.length - 0) - A_Index
			if (i < 1) {
				continue
			}
			target := this.RecursionStorage[i]
			; console.log(Type(obj) ' - ' Type(target))
			if (arr == target) {
				;! RECURSION
				OutputDebug('[ARRAY]  ! RECURSION !`n')
				return true
			}
		}
		this.RecursionStorage := arr

		return false
	}

	stringify(arr, indent := 0, indentString := '  ', initialCall := true) {
		this._validate(arr)
		ind := (lvl := indent) => StringUtilities.repeat(indentString, lvl)

		recursionDetected := this._checkRecursion(arr) ;? check for a recursion
		if (recursionDetected) {
			if (initialCall) {
				;? Clear the list to avoid the recersion detection miss-fire due to back-logging
				this.RecursionStorage := 'CLEAR' 
			}
			return '-[ <recursion> ]-'
		}

		oneLiner := !!(arr.Length <= 3) ; if the array can be printed on one line
		if (oneLiner) {
			for i in arr {
				if (ObjectUtilities.isObject(i)) {
					if (ObjectUtilities._checkRecursion(i)) {
						i := '{[ <recursion> ]}'
					}
					else {
						i := ObjectUtilities.stringify(i, 0, ' ')
					}
				}
				if (this.isArray(i) || StrSplit(i).Length > 20) { ; if the item is too long to be on one line
					oneLiner := false
					break
				}
			}
		}

		itemBreak := (lvl := indent) => (oneLiner) ? ' ' : '`n' ind(lvl)

		out := '['
		for i in arr {
			if (recursionDetected) {
				out .= '[ <recusion> ]'
				continue
			}
			if (out != '[') {
				out .= ','
			}

			if (this.isArray(i)) {
				; out .= ''
				try {
					out .= this.stringify(i, indent + 1, indentString, false)
				}
				catch {
					console.log('Cant recurse more')
				}
			} 
			else if (ObjUtils.isObject(i)) {
				if (ObjectUtilities._checkRecursion(i)) {
					out .= itemBreak(indent + 1) '{[ <recursion> ]}' itemBreak(indent + 1)
				}
				else {
					out .= itemBreak(indent - 2) ObjUtils.stringify(i, indent + 1, indentString, true) itemBreak(indent + 1)
				}
			} 
			else {
				out .= itemBreak(indent + 1) i
			}
		}

		if (initialCall) {
			;? Clear the list to avoid the recersion detection miss-fire due to back-logging
			this.RecursionStorage := 'CLEAR' 
		}
		return out itemBreak() ']'
	}

	/** 
	 * @param {Array} arr The array to check
	*/
	isArray(arr) {
		return (Type(arr) == 'Array')
	}

	/** 
	 * @param {Array} arr The array to check
	 * @param {Object} item The item to check for
	 * @return {Number} The index of the item in the array, or -1 if not found
	*/
	indexOf(arr, item) {
		this._validate(arr)
		for i in arr {
			if (i == item) {
				return A_Index
			}
		}
		return -1
	}

	/** 
	 * @param {Array} arr The array to check
	 * @param {Any} item The item to check for
	 * @return {Boolean} True if the item is in the array, false otherwise
	*/
	contains(arr, item) {
		this._validate(arr)
		return (this.indexOf(arr, item) != -1)
	}

	/** 
	 * @param {Array} arr The array to join together
	 * @param {String} separator The separator to use between items
	 * @return {String} The joined array
	*/
	join(arr, separator := '', recurse := false) {
		this._validate(arr)
		out := ''
		for i in arr {
			if (out != '') {
				out .= separator
			}
			if (Type(i) != 'String') {
				if (recurse && this.isArray(i)) {
					out .= '[ ' this.join(i) ' ]'
				}
			}
			else {
				out .= i
			}
		}
		return out
	}

	/** 
	 * @param {Array} arr The array to clean up
	 * @return {Array} The cleaned up array
	*/
	cleanUp(arr) {
		this._validate(arr)
		out := []
		for i in arr {
			if (i != '') {
				out.push(i)
			}
		}
		return out
	}

	

	; private
	_validate(arr) {
		if (!this.isArray(arr)) {
			throw 'ArrayUtilities._validate: arr is not an array'
		}
	}
}

/** 
 * A collection of utilities for working with arrays
 * - `isArray` - Returns true if the object is an object, false otherwise
 * - `indexOf` - Returns the index of the item in the array, or -1 if not found
 * - `join` - Joins the array together with the specified separator
 * - `cleanUp` - Removes empty items from the array
*/
class ArrUtils extends ArrayUtilities {
}

ArrayUtilities.Base := ArrayUtilities()


; arr := ['apple', 'banana', 'cherry']
; OutputDebug(ArrUtils.join(arr, '-') '`n')
; OutputDebug(ArrUtils.indexOf(arr, 'banana'))