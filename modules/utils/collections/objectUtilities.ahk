
/** 
 * A collection of utilities for working with objects
 * - `isObject` - Returns true if the object is an object, false otherwise
 * - `hasKey` - Returns the value of the key if it exists, false otherwise
 * - `keys` - Returns an array of keys from the object
 * - `values` - Returns an array of values from the object
*/
class ObjectUtilities extends CollectionBase {
	__New() {
		super.__Init('Object')
	}

	/** 
	 * @param {Object} obj The object to stringify
	 * @param {Number} indent The number of indents to use
	 * @param {String} indentString The string to use for indents
	 * @param {Boolean} isValue Is this object a value iside another object?
	 * @returns {String} A string representation of the object
	*/
	; stringify(obj, indent := 0, indentString := "  ", isValue := false, initialCall := true) {
	; 	;? tmp crude but working tostring feature
	; 	out := []
	; 	for key, value in obj.OwnProps() {
	; 		line := key ': '
	; 		if (ArrayUtilities.isArray(value)) {
	; 			line .= ArrayUtilities.stringify(value)
	; 		}
	; 		else if (this.isObject(value)) {
	; 			line .= this.stringify(value)
	; 		}
	; 		else {
	; 			line .= value
	; 		}
	; 		line .= '`n'

	; 		out.Push(line)
	; 	}

	; 	return ArrayUtilities.join(out, '')
	; }

	

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
		out := {}
		keyNames := [
			'Hwnd', 'Title', 'Text', 'Name'
		]

		for i, key in keyNames {
			value := ''
			try value := g.%key%
			if (value) {
				out.%key% := value
			}
		}
		
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