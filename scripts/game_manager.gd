extends Node
class_name GManager

@onready var _world : World = $WorldScn
@onready var _save_game : SaveGame
@onready var _level_data : LevelData


func _ready():
	_level_data = LevelData.new()
	_save_game = SaveGame.new()
	
	_save_game.set_level_data(_level_data)
	_save_game.load_savegame()
	_level_data = _save_game.get_level_data()
	
	_world.player_win.connect(_on_player_win)
	_world.player_loss.connect(_on_player_loss)
	_world.splash_timeout.connect(_on_splash_timeout)

	_world.setup(_level_data)
	_world.start_game()
	pass


func _on_player_win():
	_world.stop_player_timer()
	_world.blur_screen()
	_world.win_splash_show()
	_world.start_splash_timer()
	pass
	
	
func _on_player_loss():
	_world.show_loss_splash()
	_world.start_splash_timer()
	pass


func _on_splash_timeout():
	_level_data.level += 1
	_save_game.write_savegame()
	
	_world.blur_screen_remove()
	_world.win_splash_hide()
	_world.setup(_level_data)
	_world.start_game()
	pass
