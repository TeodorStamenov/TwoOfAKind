extends Control
class_name Card

signal flip_started_signal(value)
signal flip_finish_signal

@onready var Explosion = preload("res://particles/explosion.tscn")
@onready var card_highlight_animation = $CardHighlightAnimation

@export var index = 0
@onready var face = $Back/Face
@onready var flipAnimation = $Animations
@onready var initial_material = $Back.material

func _on_touch_screen_button_pressed():
	flipAnimation.play("flip")
	pass


func _on_animation_started(anim_name):
	if anim_name == "flip":
		$Button.visible = false
		$Back.material = null
		emit_signal("flip_started_signal", self)
	pass


func _on_animation_finished(anim_name):
	if anim_name == "flip":
		emit_signal("flip_finish_signal")
	elif anim_name == "hide":
		$Button.visible = true
		$Back.material = initial_material
	pass


func start_explosion():
	var explosion = Explosion.instantiate() as CPUParticles2D
	add_child(explosion)
	explosion.position = face.position
	explosion.emitting = true
	pass
