extends Control

@onready var stars = [$Star1, $Star2, $Star3]

# Called when the node enters the scene tree for the first time.
func _ready():
	for star in stars:
		star.foreground.z_index = 1
		star.foreground.size.x = 0
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
