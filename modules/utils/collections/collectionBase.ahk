Global collectionRecursionStorage := []
class CollectionBase {
	__Init(collectionType := 'BASE') {
		; OutputDebug('-------- INIT --------  `n')
		;? The current recursion storage
		this._collectionType := collectionType
		this._prefix := (*) => StrUpper(this._collectionType)
	}
}