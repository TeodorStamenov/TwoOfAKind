extends Control

@onready var WinSplash = preload("res://scenes/level_win_splash.tscn")
@onready var Star = preload("res://scenes/star.tscn")
@onready var stars = $HUD.stars

const TIMER_SECONDS = 80
const NUMBER_OF_CARDS = 12

@onready var points = 0
@onready var target_star = null
@onready var current_star_idx = 0
@onready var pairs = NUMBER_OF_CARDS / 2
@onready var current_pair = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$Board.match_pairs_signal.connect(_on_board_match_pairs)
	$HUD/TimerScn.start_timer(TIMER_SECONDS)
	$HUD/TimerScn.time_elapsed.connect(_on_timer_elapsed)
	
	target_star = stars[current_star_idx]
	points = target_star.max_points / NUMBER_OF_CARDS + 15
	
	$Timer.start()
	pass


func _on_timer_elapsed():
	print("TIME ELAPSED")
	pass
	
	
func calculate_target_star():
	if target_star.current_points >= target_star.max_points:
		current_star_idx += 1
		if current_star_idx < stars.size():
			target_star = stars[current_star_idx]
	pass


func _on_board_match_pairs():
	calculate_target_star()
	
	$Board.start_cards_vanish()
	$Board.start_cards_explosion()
	
	flying_star($Board.first_card.face.global_position, target_star.position, 1)
	flying_star($Board.second_card.face.global_position, target_star.position, 2)

	$Board.reset_cards()
	
	current_pair += 1
	if current_pair == pairs:
		$Timer.start()
	pass


func flying_star(start_pos, end_pos, mask):
	var flying_star = Star.instantiate()
	add_child(flying_star)
	flying_star.set_collision_mask_value(mask, true)
	flying_star.z_index = 2
	flying_star.global_position = start_pos
	start_star_animation(flying_star, end_pos)
	pass


func start_star_animation(star, end_pos):
	var final_scale = star.scale
	
	var tween = create_tween()
	tween.parallel().tween_property(star, "scale", Vector2(final_scale), 0.400).from(Vector2(0, 0))
	tween.parallel().tween_property(star, "modulate", Color(1,1,1,1), 0.400).from(Color(1,1,1,0))
	tween.chain().tween_callback(star.start_ghost)
	tween.chain().tween_property(star, "position", end_pos, 0.800).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN).finished.connect(_star_fly_end)
	tween.tween_callback(star.queue_free)
	pass


func _star_fly_end():
	var points_left = target_star.take_hit(points)
	if points_left > 0 and current_star_idx < (stars.size() - 1):
		stars[current_star_idx+1].fill_extend(points_left)
	pass


func _on_timer_timeout():
	print("CONGRATULATIONS")
	star_win_splash()
	pass


func star_win_splash():
	var win_splash = WinSplash.instantiate()
	win_splash.scale = Vector2(0,0)
	win_splash.position = self.size / 2 - win_splash.pivot_offset
	add_child(win_splash)
	win_splash.start_appear_anim()
	pass
