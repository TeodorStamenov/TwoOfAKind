extends Control

signal time_elapsed

@onready var time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func start_timer(value):
	time = value
	_format_time()
	$Timer.start()
	pass


func _on_timer_timeout():
	time = time - 1
	
	if time <= 0:
		emit_signal("time_elapsed")
		$Timer.stop()
	
	_format_time()
	pass
	
	
func _format_time():
	var minutes = time / 60
	var seconds = fmod(time, 60)
	$TimerDigits.text = "%1d:%02d" % [minutes, seconds]
	pass
