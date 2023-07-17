extends Control
class_name Level

func set_level(value):
	if value > 9:
		$HBoxContainer/Tens.set_texture(load("res://assets/ui/bubble/" + str(value/10) + ".png"))
	$HBoxContainer/Ones.set_texture(load("res://assets/ui/bubble/" + str(value%10) + ".png"))
	pass
