extends Control

const TIMER_SECONDS = 60

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start_timer(TIMER_SECONDS)
	$Timer.tween.finished.connect(_on_timer_elapsed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_elapsed():
	print("TIME ELAPSED")

