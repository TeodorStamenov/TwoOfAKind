extends Node
class_name SaveGame


var _level_data : LevelData = null


func set_level_data(data: LevelData):
	_level_data = data
	pass
	
	
func get_level_data():
	return _level_data
	

func load_savegame():
	var file = FileAccess.open(Globals.SAVE_GAME_PATH, FileAccess.READ)
	if not FileAccess.file_exists(Globals.SAVE_GAME_PATH):
		write_savegame()
		return
	
	
	var content := file.get_as_text()
	file.close()
	
	var data: Dictionary = JSON.parse_string(content)
	_level_data.level = data.level
	_level_data.time = data.time
	
	return _level_data
	
	
func write_savegame():
	var file = FileAccess.open(Globals.SAVE_GAME_PATH, FileAccess.WRITE)
	if file == null:
		printerr("Could not open the file %s", FileAccess.get_open_error())
		return
	
	var data := {
		"level": _level_data.level,
		"time": _level_data.time
	}
	
	var json_string := JSON.stringify(data)
	file.store_string(json_string)
	file.close()
	
