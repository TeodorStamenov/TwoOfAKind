extends Control
class_name Card

signal on_flip_started_signal(value)
signal on_flip_finish_signal

@export var index = 0
@onready var face = $Back/Face
@onready var flipAnimation = $CardFlipAnimations

@onready var initial_material = $Back.material

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_touch_screen_button_pressed():
	flipAnimation.play("card_flip")
	pass # Replace with function body.


func _on_flip_animation_started(anim_name):
	if anim_name == "card_flip":
		$Button.visible = false
		$Back.material = null
		emit_signal("on_flip_started_signal", self)
	pass # Replace with function body.


func _on_flip_animation_finished(anim_name):
	if anim_name == "card_flip":
		emit_signal("on_flip_finish_signal")
	elif anim_name == "card_hide":
		$Button.visible = true
		$Back.material = initial_material
	pass # Replace with function body.
