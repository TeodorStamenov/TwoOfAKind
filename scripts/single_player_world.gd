extends Control

@onready var Star = preload("res://scenes/star.tscn")
@onready var Ghost = preload("res://particles/ghost.tscn")
@onready var FlyStar = preload("res://scenes/fly_star.tscn")

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
	
	var first_star = FlyStar.instantiate()
	add_child(first_star)
	first_star.global_position = $Board.first_card.face.global_position
	start_star_animation(first_star)
	
#	var second_star = FlyStar.instantiate()
#	add_child(second_star)
#	second_star.global_position = $Board.second_card.face.global_position - second_star.pivot_offset
#	start_star_animation(second_star)
#
	$Board.reset_cards()
	pass


func start_star_animation(star):
	var final_scale = star.scale
	
	var tween : Tween
	tween = create_tween()
	tween.parallel().tween_property(star, "scale", Vector2(final_scale), 2).from(Vector2(0, 0))
	tween.parallel().tween_property(star, "modulate", Color(1,1,1,1), 2).from(Color(1,1,1,0))
	tween.chain().tween_property(star, "position", $HUD/Star1.global_position, 4).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	pass
