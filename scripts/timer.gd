extends Control

@onready var initial_x = $BarElapsed.size.x
var tween : Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func start_timer(seconds):
	tween = create_tween()
	tween.tween_property($BarElapsed, "size:x", 0, seconds).from(initial_x).set_ease(Tween.EASE_IN)
	pass
