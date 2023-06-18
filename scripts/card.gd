extends Control
class_name Card

@onready var Explosion = preload("res://particles/explosion.tscn")

signal flip_started_signal(value)
signal flip_finish_signal

@export var index = 0
@onready var face = $Back/Face
@onready var flipAnimation = $Animations
@onready var initial_material = $Back.material

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_touch_screen_button_pressed():
	flipAnimation.play("flip")
	pass # Replace with function body.


func _on_animation_started(anim_name):
	if anim_name == "flip":
		$Button.visible = false
		$Back.material = null
		emit_signal("flip_started_signal", self)
	pass # Replace with function body.


func _on_animation_finished(anim_name):
	if anim_name == "flip":
		emit_signal("flip_finish_signal")
	elif anim_name == "hide":
		$Button.visible = true
		$Back.material = initial_material
	pass # Replace with function body.


func start_explosion():
	var explosion = Explosion.instantiate() as CPUParticles2D
	add_child(explosion)
	explosion.position = face.position
	explosion.emitting = true
	pass
