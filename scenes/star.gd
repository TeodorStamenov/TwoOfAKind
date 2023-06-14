extends TextureRect

@onready var fill = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$StarForeground.size.x = 0;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func fillStar(value):
	var tween : Tween
	tween = create_tween()
	tween.parallel().tween_property($StarForeground, "size:x", value, 0.5).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	pass


func _on_timer_timeout():
	fill += 60
	fillStar(fill)
	pass # Replace with function body.
