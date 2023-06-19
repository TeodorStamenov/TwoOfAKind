extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Star1.z_index = 2
	$Star2.z_index = 2
	$Star3.z_index = 2
	
	$Star1/StarForeground.size.x = 0
	$Star2/StarForeground.size.x = 0
	$Star3/StarForeground.size.x = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
