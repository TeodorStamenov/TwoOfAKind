extends Control

@onready var Star = preload("res://scenes/star.tscn")

const TIMER_SECONDS = 60
@onready var points = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	$Board.match_pairs_signal.connect(_on_board_match_pairs)
	$Timer.start_timer(TIMER_SECONDS)
	$Timer.tween.finished.connect(_on_timer_elapsed)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_elapsed():
	print("TIME ELAPSED")
	pass	
	
	
func _star_fly_end(star):
	star.take_hit(points)
	points += 100
	pass

func _on_board_match_pairs():
	$Board.start_cards_vanish()
	$Board.start_cards_explosion()
	
	flying_star($Board.first_card.face.global_position, $HUD/Star1.position)
	flying_star($Board.second_card.face.global_position, $HUD/Star1.position)
#
	$Board.reset_cards()
	pass


func flying_star(start_pos, end_pos):
	var flying_star = Star.instantiate()
	add_child(flying_star)
	flying_star.z_index = 1
	flying_star.global_position = start_pos - flying_star.pivot_offset
	start_star_animation(flying_star, end_pos)
	pass


func start_star_animation(star, end_pos):
	var final_scale = star.scale
	
	var tween = create_tween()
	tween.parallel().tween_property(star, "scale", Vector2(final_scale), 0.400).from(Vector2(0, 0))
	tween.parallel().tween_property(star, "modulate", Color(1,1,1,1), 0.400).from(Color(1,1,1,0))
	tween.chain().tween_callback(star.start_ghost)
	tween.chain().tween_property(star, "position", end_pos, 0.800).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN).finished.connect(_star_fly_end.bind($HUD/Star1))
	tween.tween_callback(star.queue_free)
	pass
