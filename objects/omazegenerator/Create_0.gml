/// @description 

randomize();

iMazeWidth = global.selectedOptions.iMazeWidth;
iMazeHeight = global.selectedOptions.iMazeHeight;
iPathThickness = 3;
// Creates a new ds_grid where all initial cells have the value of 0
dgMaze = ds_grid_create(iMazeWidth, iMazeHeight);

iTotalMazeCellsCount = iMazeWidth * iMazeHeight;
iVisitedMazeCellsCount = 0;
// Holds a list of visited cells 
dsVisitedCells = ds_stack_create();

// Stack needs to have some data initially, so we push the top-left-most cell into it
function initializeOriginCell(){
	var _pCell = new pair(0, 0);
	ds_stack_push(dsVisitedCells, _pCell);
	iVisitedMazeCellsCount++;
	dgMaze[# _pCell.x, _pCell.y] |= CELL_VISITED;
}

activeCamera = view_camera[0];
drawingSurface = surface_create(iMazeWidth * (iPathThickness + 1), iMazeHeight * (iPathThickness + 1));
surfaceDrawOffset = iPathThickness * 3;

initializeOriginCell();
// Cell Size in pixels
#macro CELL_SIZE_PX 16
// Cell flags
#macro CELL_PATH_N 0x01
#macro CELL_PATH_E 0x02
#macro CELL_PATH_S 0x04
#macro CELL_PATH_W 0x08

#macro CELL_VISITED 0x10
#macro CELL_DRAWN 0x20

#macro CELL_NORTH 0
#macro CELL_EAST 1
#macro CELL_SOUTH 2
#macro CELL_WEST 3

