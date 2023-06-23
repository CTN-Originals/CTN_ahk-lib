# ObjectUtilities

A collection of utilities for working with objects.

## Methods

### `isObject(obj)`

Returns true if the object is an object, false otherwise.

- `obj` - The object to check.

### `hasKey(obj, key)`

Returns the value of the key if it exists, false otherwise.

- `obj` - The object to retrieve the values from.
- `key` - The key to check for.

### `keys(obj)`

Returns an array of keys from the object.

- `obj` - The object to retrieve the keys from.

### `values(obj)`

Returns an array of values from the object.

- `obj` - The object to retrieve the values from.

### `stringify(obj, indent = 0, indentString = "  ")`

Returns a string representation of the object.

- `obj` - The object to stringify.
- `indent` - The number of indents to use (default: 0).
- `indentString` - The string to use for indents (default: "  ").

## Usage

```ahk
#include ObjectUtilities.ahk

; Check if an object is an object
isObj := ObjectUtilities.isObject({a: 10, b: 20, c: 30})
console.log('isObj: ' isObj) ; true

; Get the value of a key if it exists
value := ObjectUtilities.hasKey({a: 10, b: 20, c: 30}, "b")
console.log('value: ' value) ; 20

; Get an array of keys from an object
keys := ObjectUtilities.keys({a: 10, b: 20, c: 30})
console.log(keys) ; [a, b, c]

; Get an array of values from an object
values := ObjectUtilities.values({a: 10, b: 20, c: 30})
console.log(values) ; [10, 20, 30]

; Stringify an object
str := ObjectUtilities.stringify({a: {b: 20, c: 30}, d: [40, 50, 60]})
console.log('str: ' str) ; {a: {b: 20, c: 30}, d: [40, 50, 60]}
```

<br>

# ArrayUtilities

This is a library of utilities for working with arrays in AutoHotkey v2. It includes the following methods:

- `isArray` - Returns true if the object is an array, false otherwise
- `indexOf` - Returns the index of the item in the array, or -1 if not found
- `join` - Joins the array together with the specified separator
- `cleanUp` - Removes empty items from the array
- `contains` - Returns true if the item is in the array, false otherwise

## Usage

To use this library, simply include the `ArrayUtilities` class in your script. You can then create an instance of the class and call its methods as needed.

```ahk
#include ArrayUtilities.ahk

arr := ['apple', 'banana', '', 'cherry']

; Check if an object is an array
isArray := ArrayUtilities.isArray(arr)
console.log(isArray) ; true

; Get the index of an item in the array
index := ArrayUtilities.indexOf(arr, "banana")
console.log(index) ; 1

; Join the array together with a separator
joined := ArrayUtilities.join(arr, "-")
console.log(joined) ; apple-banana--cherry

; Remove empty items from the array
cleaned := ArrayUtilities.cleanUp(arr)
console.log(cleaned) ; [apple, banana, cherry]

; Check if an item is in the array
arrContains := ArrayUtilities.contains(arr, "banana")
console.log(arrContains) ; true
```

## Class Methods

### `isArray(arr)`

Returns true if the object is an array, false otherwise.

- `arr` - The object to check.

### `indexOf(arr, item)`

Returns the index of the item in the array, or -1 if not found.

- `arr` - The array to check.
- `item` - The item to check for.

### `contains(arr, item)`

Returns true if the item is in the array, false otherwise.

- `arr` - The array to check.
- `item` - The item to check for.

### `join(arr, separator)`

Joins the array together with the specified separator.

- `arr` - The array to join together.
- `separator` - The separator to use between items.

### `cleanUp(&arr)`

Removes empty items from the array.

- `arr` - The array to clean up.

### `stringify(arr, indent := 0, indentString := '  ')`

Converts an array to a string representation.

- `arr` - The array to convert.
- `indent` - The number of spaces to indent each level of the array.
- `indentString` - The string to use for indentation.

## Extending the Library

You can extend the `ArrayUtilities` class by creating a new class that inherits from it. For example:

```ahk
class MyArrayUtils extends ArrayUtilities {
    ; Add your own methods here
}
```

You can then create an instance of your new class and call its methods as needed.

```ahk
utils := new MyArrayUtils()
```

## Example

Here is an example of how to use the `ArrayUtilities` library:

```ahk
#include ArrayUtilities.ahk

arr := ['apple', 'banana', 'cherry']
utils := new ArrayUtilities()

if (utils.isArray(arr)) {
    MsgBox "arr is an array"
}

index := utils.indexOf(arr, "banana")
if (index != -1) {
    MsgBox "banana is at index " index " in the array"
}

joined := utils.join(arr, "-")
MsgBox joined

cleaned := utils.cleanUp(arr)
MsgBox cleaned

if (utils.contains(arr, "banana")) {
    MsgBox "banana is in the array"
}
```