extends TextureRect

var INITIAL_SHINE_PROGRESS = 0.0
var INITIAL_SHINE_SIZE = 0.01

const SHINE_TIME = 5.450
const TIMER_LIMIT = 2

var time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	if time > TIMER_LIMIT:
		run_highlight_effect()
		time = 0
	pass


func run_highlight_effect():
	var tween : Tween
	tween.tween_property(self, "material:shader_parameter/shine_size", 0.1, SHINE_TIME / 2).from(0.01)
	tween.tween_property(self, "material:shader_parameter/shine_size", 0.01, SHINE_TIME / 2).from(0.1)
	pass
