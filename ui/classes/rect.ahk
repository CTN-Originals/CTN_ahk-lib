#Include ..\..\modules\debug\console\import.ahk

class Rect {
	/** 
	 * @param {Object|Integer} [obj_x] The object {x, y, width, height} or just the x value as a number
	 * @param {Integer} [y] The y value
	 * @param {Integer} [width] The width value
	 * @param {Integer} [height] The height value
	 * @example Rect(10, 10, 100, 30)
	 * @example Rect({x: 10, y: 10, width: 100, height: 30})
	*/
	__New(obj_x?, y?, width?, height?) {
		;?? does this need to be unset initially? to prevent (e.g.) text elements from having a set widthXheight?
		this.x := 10
		this.y := 10
		this.width := 100
		this.height := 30

		console.log(Type(obj_x))
		if (Type(obj_x) == 'Integer' || Type(obj_x) == 'Float') {
			this.x := obj_x
			console.log(!!(y))
			console.log(width ?? 'unset')
			
		}
		else if (Type(obj_x) == 'Object') {
			
		}

		console.log(this)
	}
}