extends Control

@onready var level = 1
@onready var number_texture = load("res://assets/ui/bubble/0.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	set_level(level)
	pass # Replace with function body.
	

func set_level(value):
	if value > 9:
		$HBoxContainer/Tens.set_texture(load("res://assets/ui/bubble/" + str(value/10) + ".png"))
	$HBoxContainer/Ones.set_texture(load("res://assets/ui/bubble/" + str(value%10) + ".png"))
	pass
