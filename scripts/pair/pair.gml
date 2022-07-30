///@description Holds two values inside a single structure
///@param {int} _x
///@param {int} _y
function pair(_x, _y) constructor{

	x = _x;
	y = _y;
	
	///@desc reasign pair values
	function set(_x, _y){
		x = _x;
		y = _y;
	}

	///@desc Check if this cell is valid
	function is_valid(){
		if(x == -1 && y == -1){
			return false;	
		}
		return true;
	}
}