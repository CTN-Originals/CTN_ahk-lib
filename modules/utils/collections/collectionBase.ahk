Global collectionRecursionStorage := []
class CollectionBase {
	__Init(collectionType := 'BASE') {
		; OutputDebug('-------- INIT --------  `n')
		;? The current recursion storage
		this._collectionType := collectionType
		this._prefix := (*) => StrUpper(this._collectionType)
	}

	RecursionStorage {
		get {
			global
			OutputDebug('[' this._prefix() '] get storage | Size: ' collectionRecursionStorage.Length '`n')
			return collectionRecursionStorage
		}
		set {
			global
			if (Value == 'null')
				return
			
			OutputDebug('[' this._prefix() '] set storage | Size: ' collectionRecursionStorage.Length ' + 1' '`n')
			if (Value == 'CLEAR') {
				OutputDebug('---- [' this._prefix() '] Clearing RecursionStorage ---- `n`n')
				collectionRecursionStorage := []
			}
			else {
				collectionRecursionStorage.Push(Value)
			}
		}
	}

	_checkRecursion(collection, depth := 0) {
		out := false
		loop(this.RecursionStorage.Length) {
			i := (this.RecursionStorage.length - 0) - A_Index
			if (i < 1) {
				continue
			}
			target := this.RecursionStorage[i]
			; console.log(Type(collection) ' - ' Type(target))
			if (collection == target) {
				;! RECURSION
				console.log('[' this._prefix() '] ! RECURSION !')
				out := true
			}
			; else if (depth == 0) {
			; 	out := this._checkRecursion(collection, depth + 1)
			; }

			if (out) {
				break
			}
		}
		this.RecursionStorage := collection

		return out
	}
}