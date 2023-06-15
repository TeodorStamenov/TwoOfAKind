extends TextureRect

@onready var points = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	$StarForeground.size.x = 0;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func fill_star(value):
	var tween : Tween
	tween = create_tween()
	tween.parallel().tween_property($StarForeground, "size:x", value, 0.5).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	pass

