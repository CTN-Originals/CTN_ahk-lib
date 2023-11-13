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
			return this._recursionStorage
		}
		set {
			OutputDebug('[ARRAY] set storage | Size: ' this._recursionStorage.Length ' + 1' '`n')
			if (Value == 'CLEAR') {
				OutputDebug('---- [ARRAY] Clearing RecursionStorage ---- `n')
				this._recursionStorage := []
			}
			else {
				this._recursionStorage.Push(Value)
			}
		}
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
				console.log('! RECURSION !')
				return true
			}
		}
		this.RecursionStorage := obj

		;TODO loop thru the recursion history and check for duplicates
		
		return false
	}

	stringify(arr, indent := 0, indentString := '  ') {
		this._validate(arr)
		ind := (lvl := indent) => StringUtilities.repeat(indentString, lvl)

		oneLiner := true ; if the array can be printed on one line
		if (arr.Length <= 3) {
			for i in arr {
				if (ObjectUtilities.isObject(i)) {
					i := ObjectUtilities.stringify(i)
				}
				if (StrSplit(i).Length > 20) { ; if the item is too long to be on one line
					oneLiner := false
					break
				}
			}
		}
		else {
			oneLiner := false
		}
		itemBreak := (lvl := indent) => (oneLiner) ? ' ' : '`n' ind(lvl)

		out := '['
		for i in arr {
			if (out != '[') {
				out .= ','
			}
			if (this.isArray(i)) {
				out .= '[recurse] '
				try {
					out .= this.stringify(i, indent + 1, indentString)
				}
				catch {
					console.log('Cant recurse more')
				}
			} 
			else if (ObjUtils.isObject(i)) {
				out .= itemBreak(indent - 2) ObjUtils.stringify(i, indent + 1, indentString)
			} 
			else {
				out .= itemBreak(indent + 1) i
			}
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