extends TextureRect

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func run_highlight_effect():
	get_parent().get_node("CardAnimations").play("card_highlight")
	pass


func _on_highlight_timer_timeout():
	run_highlight_effect()
	pass # Replace with function body.
