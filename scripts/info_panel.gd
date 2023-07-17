extends Control
class_name InfoPanel

@onready var stars = [$StarScn1, $StarScn2, $StarScn3]
@onready var player_timer = $TimerScn as PlayerTimer
@onready var level = $LevelScn as Level


func setup():
	setup_stars()
	_set_level(LevelData.level)
	_set_timer(LevelData.time)
	pass


func setup_stars():
	for star in stars:
		star.foreground.z_index = 1
		star.foreground.size.x = 0
		star.current_points = 0
	pass
	
	
func start_player_timer():
	player_timer.start_timer()
	pass


func stop_player_timer():
	player_timer.stop_timer()
	pass

func _set_level(value: int):
	level.set_level(value)
	pass


func _set_timer(value: int):
	player_timer.set_time(value)
	pass


