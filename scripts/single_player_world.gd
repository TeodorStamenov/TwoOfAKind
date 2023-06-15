extends Control

const TIMER_SECONDS = 60
@onready var points = 100

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


func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		print("Mouse click at: ", event.position)
		var Star = preload("res://scenes/star.tscn")
		var star = Star.instantiate()
		add_child(star)
		star.set_position(event.position)
		
		var tween : Tween
		tween = create_tween()
		tween.tween_property(star, "position", $HUD/Star1.position, 1)
		tween.finished.connect(_star_fly_end.bind(star))
	pass
	
func _star_fly_end(star):
	$HUD/Star1.fill_star(points)
	remove_child(star)
	points += 100
	pass
