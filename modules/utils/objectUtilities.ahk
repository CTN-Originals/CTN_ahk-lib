/** 
 * A collection of utilities for working with objects
 * - `isObject` - Returns true if the object is an object, false otherwise
 * - `hasKey` - Returns the value of the key if it exists, false otherwise
 * - `keys` - Returns an array of keys from the object
 * - `values` - Returns an array of values from the object
*/
class ObjectUtilities {
	/** 
	 * @param {Object} obj The object to check
	 * @returns {Boolean} True if the object is an object, false otherwise
	*/
	isObject(obj) {
		try obj.OwnProps()
		catch {
			return false
		}
		return (isObject(obj) && Type(obj) != "Array")
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
	 * @param {Object} obj The object to stringify
	 * @param {Number} indent The number of indents to use
	 * @param {String} indentString The string to use for indents
	 * @returns {String} A string representation of the object
	*/
	stringify(obj, indent := 0, indentString := "  ") {
		out := ''
		if (this.keys(obj).Length > 0) {
			out := StrUtils.repeat(indentString, indent - 1) "{`n"
		}
		else {
			out := StrUtils.repeat(indentString, indent - 1) "{"
		}

		keys := this.keys(obj)

		for k, v in keys {
			key := keys[k]
			value := obj.%key%
			out .= StrUtils.repeat(indentString, indent + 1) key ": "
			if (ObjUtils.isObject(value)) {
				out .= this.stringify(value, indent + 1, indentString)
			} 
			else if (ArrUtils.isArray(value)) {
				out .= ArrUtils.stringify(value, indent + 1, indentString)
			}
			else {
				out .= value
			}
			out .= ",`n"
		}
		out .= StrUtils.repeat(indentString, indent) "}"
		return out
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