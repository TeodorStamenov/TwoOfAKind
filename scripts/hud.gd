extends Control

@onready var stars = [$StarScn1, $StarScn2, $StarScn3]
@onready var player_timer = $TimerScn
@onready var level = $LevelScn

# Called when the node enters the scene tree for the first time.
func _ready():
	setup_stars()
	pass


func setup_stars():
	for star in stars:
		star.foreground.z_index = 1
		star.foreground.size.x = 0
		star.current_points = 0
	pass
	


func next_level():
	player_timer.start_timer(Globals.PLYER_TIMER_SECONDS)
	level.increment()
	setup_stars()
	pass
	

func stop_player_timer():
	player_timer.stop_timer()
	pass
