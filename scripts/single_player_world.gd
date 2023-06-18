extends Control

@onready var Star = preload("res://scenes/star.tscn")

const TIMER_SECONDS = 60
@onready var points = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	$Board.match_pairs_signal.connect(_on_board_match_pairs)
	$Timer.start_timer(TIMER_SECONDS)
	$Timer.tween.finished.connect(_on_timer_elapsed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_elapsed():
	print("TIME ELAPSED")
	pass	
	
	
func _star_fly_end(star):
	$HUD/Star1.fill_star(points)
	remove_child(star)
	points += 100
	pass

func _on_board_match_pairs():
	$Board.start_cards_vanish()
	$Board.start_cards_explosion()
	
	var first_star = Star.instantiate()
	add_child(first_star)
	first_star.z_index = 1
	first_star.global_position = $Board.first_card.face.global_position - first_star.pivot_offset
	start_star_animation(first_star)
	
	var second_star = Star.instantiate()
	add_child(second_star)
	second_star.z_index = 1
	second_star.global_position = $Board.second_card.face.global_position - second_star.pivot_offset
	start_star_animation(second_star)
#
	$Board.reset_cards()
	pass


func start_star_animation(star):
	var final_scale = star.scale
	print(final_scale)
	
	var tween = create_tween()
	tween.parallel().tween_property(star, "scale", Vector2(final_scale), 0.400).from(Vector2(0, 0))
	tween.parallel().tween_property(star, "modulate", Color(1,1,1,1), 0.400).from(Color(1,1,1,0))
	tween.chain().tween_callback(star.start_ghost)
	tween.chain().tween_property(star, "position", $HUD/Star1.position, 0.800).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	tween.tween_callback(star.queue_free)
	pass
