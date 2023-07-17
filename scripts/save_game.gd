extends Node


func load_savegame():
	var file = FileAccess.open(Globals.SAVE_GAME_PATH, FileAccess.READ)
	if not FileAccess.file_exists(Globals.SAVE_GAME_PATH):
		write_savegame()
		return
	
	var content := file.get_as_text()
	file.close()
	
	var data: Dictionary = JSON.parse_string(content)
	LevelData.level = data.level
	LevelData.time = data.time
	pass
	
func write_savegame():
	var file = FileAccess.open(Globals.SAVE_GAME_PATH, FileAccess.WRITE)
	if file == null:
		printerr("Could not open the file %s", FileAccess.get_open_error())
		return
	
	var data := {
		"level": LevelData.level,
		"time": LevelData.time
	}
	
	var json_string := JSON.stringify(data)
	file.store_string(json_string)
	file.close()
	pass
