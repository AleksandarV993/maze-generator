/// @description 

// Surface gets destroyed whenever a resize happens, make sure the game doesn't crash!
if(!surface_exists(drawingSurface)){
	drawingSurface = surface_create(iMazeWidth * CELL_SIZE_PX, iMazeHeight * CELL_SIZE_PX);
}

// Keep creating maze only if number of visited cells is not equal to total number of cells
if(iVisitedMazeCellsCount < iTotalMazeCellsCount){
	// Create a set of unvisited neighbours
	var _arrNeighbourCells = [];
	var _pCell = ds_stack_top(dsVisitedCells);
	// N
	if(_pCell.y > 0 && dgMaze[# _pCell.x, _pCell.y - 1] & CELL_VISITED == 0){
		array_push(_arrNeighbourCells, CELL_NORTH);
	}
	// E
	if(_pCell.x < iMazeWidth - 1 && dgMaze[# _pCell.x + 1, _pCell.y] & CELL_VISITED == 0){
		array_push(_arrNeighbourCells, CELL_EAST);
	}
	// S
	if(_pCell.y < iMazeHeight - 1 && dgMaze[# _pCell.x, _pCell.y + 1] & CELL_VISITED == 0){
		array_push(_arrNeighbourCells, CELL_SOUTH);
	}
	// W
	if(_pCell.x > 0 && dgMaze[# _pCell.x - 1, _pCell.y] & CELL_VISITED == 0){
		array_push(_arrNeighbourCells, CELL_WEST);
	}
	
	// Check if there are any free neighbouring cells
	var _freeNeighbourCellsCount = array_length(_arrNeighbourCells);
	if(_freeNeighbourCellsCount > 0){
		// Chose a random available neighbour
		var _iNextCellDirection = _arrNeighbourCells[irandom_range(0, _freeNeighbourCellsCount - 1)];
		// Initialize an invalid cell
		var _pNewCell = new pair(-1, -1);
		// Create path relation between neighbour and current cell
		switch(_iNextCellDirection){
			case CELL_NORTH:
				dgMaze[# _pCell.x, _pCell.y] |= CELL_PATH_N;
				dgMaze[# _pCell.x, _pCell.y - 1] |= CELL_PATH_S;
				ds_stack_push(dsVisitedCells, new pair(_pCell.x, _pCell.y - 1));
				_pNewCell.set(_pCell.x, _pCell.y - 1);
			break;
			case CELL_EAST:
				dgMaze[# _pCell.x, _pCell.y] |= CELL_PATH_E;
				dgMaze[# _pCell.x + 1, _pCell.y] |= CELL_PATH_W;
				ds_stack_push(dsVisitedCells, new pair(_pCell.x + 1, _pCell.y));
				_pNewCell.set(_pCell.x + 1, _pCell.y);
			break;
			case CELL_SOUTH:
				dgMaze[# _pCell.x, _pCell.y] |= CELL_PATH_S;
				dgMaze[# _pCell.x, _pCell.y + 1] |= CELL_PATH_N;
				ds_stack_push(dsVisitedCells, new pair(_pCell.x, _pCell.y + 1));
				_pNewCell.set(_pCell.x, _pCell.y + 1);
			break;
			case CELL_WEST:
				dgMaze[# _pCell.x, _pCell.y] |= CELL_PATH_W;
				dgMaze[# _pCell.x - 1, _pCell.y] |= CELL_PATH_E;
				ds_stack_push(dsVisitedCells, new pair(_pCell.x - 1, _pCell.y));
				_pNewCell.set(_pCell.x - 1, _pCell.y);
			break;
			default:
				show_debug_message("Wrong direction input!");
			break;
		}
		
		// If there was a valid cell, set new cell as already visited
		if(_pNewCell.is_valid()){
			dgMaze[# _pNewCell.x, _pNewCell.y] |= CELL_VISITED;
		}
		iVisitedMazeCellsCount++;
	}else{
		// There were no free neighbours
		// Backtrack!
		ds_stack_pop(dsVisitedCells);
	}
}

if(keyboard_check_released(ord("R"))){
	game_restart();
}