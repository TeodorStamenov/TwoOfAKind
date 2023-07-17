extends Node
class_name GManager

@onready var _world : World = $WorldScn


func _ready():
	SaveGame.load_savegame()
	
	_world.player_win.connect(_on_player_win)
	_world.player_loss.connect(_on_player_loss)
	_world.splash_timeout.connect(_on_splash_timeout)

	_world.setup()
	_world.start_game()
	pass


func _on_player_win():
	_world.stop_player_timer()
	_world.blur_screen()
	_world.win_splash_show()
	_world.start_splash_timer()
	
	LevelData.level += 1
	SaveGame.write_savegame()
	pass
	
	
func _on_player_loss():
	_world.show_loss_splash()
	_world.start_splash_timer()
	pass


func _on_splash_timeout():
	_world.blur_screen_remove()
	_world.win_splash_hide()
	_world.setup()
	_world.start_game()
	pass
