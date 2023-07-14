extends Control

@onready var stars = [$StarScn1, $StarScn2, $StarScn3]
@onready var player_timer = $TimerScn

# Called when the node enters the scene tree for the first time.
func _ready():
	for star in stars:
		star.foreground.z_index = 1
		star.foreground.size.x = 0
	pass


