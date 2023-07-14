extends TextureRect

# Called when the node enters the scene tree for the first time.
func _ready():
	$Face.z_index = -1
	pass # Replace with function body.


func run_highlight_effect():
#	%CardHighlightAnimation.play("card_highlight")
	pass

func _on_highlight_timer_timeout():
	run_highlight_effect()
	pass # Replace with function body.
