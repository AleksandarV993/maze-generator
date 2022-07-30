/// @description Insert description here
// You can write your code in this editor

defaultOptions = {
	iMazeWidth: 40,
	iMazeHeight: 25,
	bShowMazeBuildProcess: true,
	fMazeWallColor: c_white,
	fMazeCellColor: c_teal,
	fMazeBgColor: c_black,
	gameWindowWidth: 1366,
	gameWindowHeight: 768,
	bGameSetFullscreen: false
};

global.selectedOptions = noone;
sConfigFileName = "config.ini";
// Create default config file if it does not exist!
if(!file_exists(sConfigFileName)){
	var _fp = file_text_open_write(sConfigFileName);
	var _json_string = json_stringify(defaultOptions);
	file_text_write_string(_fp, _json_string);
	file_text_close(_fp);
	global.selectedOptions = defaultOptions;
}// Otherwise read config from the file
else{
	var _fp = file_text_open_read(sConfigFileName);
	var _file_content = file_text_read_string(_fp);
	file_text_close(_fp);
	var _dmData = json_decode(_file_content);
	//show_debug_message(_file_content);
	var arr = [];
	ds_map_keys_to_array(_dmData, arr);
	show_debug_message(arr);
	global.selectedOptions = {
		iMazeWidth: _dmData[? "iMazeWidth"],
		iMazeHeight: _dmData[? "iMazeHeight"],
		bShowMazeBuildProcess: _dmData[? "bShowMazeBuildProcess"],
		fMazeWallColor: _dmData[? "fMazeWallColor"],
		fMazeCellColor: _dmData[? "fMazeCellColor"],
		fMazeBgColor: _dmData[? "fMazeBgColor"],
		gameWindowWidth: _dmData[? "gameWindowWidth"],
		gameWindowHeight: _dmData[? "gameWindowHeight"],
		bGameSetFullscreen: _dmData[? "bGameSetFullscreen"]
	}
}

// Adjust window where necessary
window_set_size(global.selectedOptions.gameWindowWidth, global.selectedOptions.gameWindowHeight);
if(global.selectedOptions.bGameSetFullscreen){
	window_set_fullscreen(true);	
}

room_goto_next();