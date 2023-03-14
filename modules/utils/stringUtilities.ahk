
/** 
 * A collection of utilities for working with objects
 * - `split` - Splits a string into an array of strings
 * - `repeat` - Repeats a string a number of times
*/
class StringUtilities {
	/** 
	 * @param {String} str The string to be split.
	 * @param {String} delimiter The delimiter to split the string by.
	 * @returns {Array} An array of strings.
	*/
	split(str, delimiter := '') {
		if (!delimiter) {
			return StrSplit(str)
		}
		return StrSplit(str, delimiter)
	}

	/** 
	 * @param {String} str The string to repeat
	 * @param {Number} count The number of times to repeat the string
	 * @returns {String} The repeated string
	*/
	repeat(str, count) {
		out := ''
		loop(count) {
			out .= str
		}
		return out
	}
}

/** 
 * A collection of utilities for working with objects
 * - `split` - Splits a string into an array of strings
 * - `repeat` - Repeats a string a number of times
*/
class StrUtils extends StringUtilities {
}

StringUtilities.Base := StringUtilities()