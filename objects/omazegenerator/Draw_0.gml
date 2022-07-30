/// @description Insert description here
// You can write your code in this editor

// Set the target surface
surface_set_target(drawingSurface);
draw_clear_alpha(global.selectedOptions.fMazeBgColor, 1);
var _c;
// Iterate through all entries and set the appropriate 'cell' color
for(var _ix = 0; _ix < iMazeWidth; _ix++){
	for(var _iy = 0; _iy < iMazeHeight; _iy++){
		// Iterate through each pixel
		for(var _px = 0; _px < iPathThickness; _px++){
			for(var _py = 0; _py < iPathThickness; _py++){
				_c = (dgMaze[# _ix, _iy] & CELL_VISITED) ? 
					global.selectedOptions.fMazeWallColor 
					: 
					global.selectedOptions.fMazeCellColor;
				draw_point_color(_ix * (iPathThickness + 1) + _px, _iy * (iPathThickness + 1) + _py, _c);
			}
		}// End Pixel Draw
		// Draw paths where necessary
		for(var _p = 0; _p < iPathThickness; _p++){
			if(dgMaze[# _ix, _iy] & CELL_PATH_S){
				draw_point_color(
					_ix * (iPathThickness + 1) + _p, 
					_iy * (iPathThickness + 1) + iPathThickness, 
					global.selectedOptions.fMazeWallColor
				);
			}
			if(dgMaze[# _ix, _iy] & CELL_PATH_E){
				draw_point_color(
					_ix * (iPathThickness + 1) + iPathThickness,
					_iy * (iPathThickness + 1) + _p,
					global.selectedOptions.fMazeWallColor
				);
			}
		}
	}
}
// Go back to regular draw pipeline
surface_reset_target();

draw_surface_stretched(
	drawingSurface, 
	surfaceDrawOffset, 
	surfaceDrawOffset, 
	room_width - surfaceDrawOffset, 
	room_height - surfaceDrawOffset
);