extends Control

@onready var WinSplash = preload("res://scenes/level_win_splash.tscn")
@onready var Star = preload("res://scenes/star.tscn")

@onready var board = $BoardScn
@onready var info_panel = $InfoPanelScn
@onready var stars = info_panel.stars
@onready var player_timer = info_panel.player_timer

@onready var points = 0
@onready var target_star = null
@onready var current_star_idx = 0
@onready var pairs = Globals.NUMBER_OF_CARDS / 2
@onready var current_pair = 0

var win_splash = null

# Called when the node enters the scene tree for the first time.
func _ready():
	board.match_pairs_signal.connect(_on_board_match_pairs)
	player_timer.start_timer(Globals.PLYER_TIMER_SECONDS)
	player_timer.time_elapsed.connect(_on_player_timer_elapsed)
	setup_stars()
	pass


func setup_stars():
	current_pair = 0
	current_star_idx = 0
	target_star = stars[current_star_idx]
	points = target_star.max_points / Globals.NUMBER_OF_CARDS
	pass

#add game over splash
func _on_player_timer_elapsed():
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
	
	board.start_cards_vanish()
	board.start_cards_explosion()
	
	spawn_flying_star(board.first_card.face.global_position, target_star.position, 1)
	spawn_flying_star(board.second_card.face.global_position, target_star.position, 2)

	board.reset_cards()
	
	current_pair += 1
	if current_pair == pairs:
		$DelaySplash.start()
	pass


func spawn_flying_star(start_pos, end_pos, mask):
	var flying_star = Star.instantiate()
	add_child(flying_star)
	flying_star.set_collision_mask_value(mask, true)
	flying_star.z_index = 2
	flying_star.global_position = start_pos
	start_star_fly_animation(flying_star, end_pos)
	pass


func start_star_fly_animation(star, end_pos):
	var final_scale = star.scale
	
	var tween = create_tween()
	tween.parallel().tween_property(star, "scale", Vector2(final_scale), 0.400).from(Vector2(0, 0))
	tween.parallel().tween_property(star, "modulate", Color(1,1,1,1), 0.400).from(Color(1,1,1,0))
	tween.chain().tween_callback(star.start_ghost)
	tween.chain().tween_property(star, "position", end_pos, 0.800).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN).finished.connect(_on_star_fly_end)
	tween.tween_callback(star.queue_free)
	pass


func _on_star_fly_end():
	var points_left = target_star.take_hit(points)
	if points_left > 0 and current_star_idx < (stars.size() - 1):
		stars[current_star_idx+1].fill_extend(points_left)
	pass


func _on_delay_splash_timeout():
	print("CONGRATULATIONS")
	info_panel.stop_player_timer()
	show_blur()
	show_win_splash()
	get_tree().create_timer(4).timeout.connect(next_level)
	pass


func next_level():
	hide_win_splash()
	hide_blur()
	setup_stars()
	board.next_level()
	info_panel.next_level()
	pass


func show_blur():
	$BlurEffect.visible = true
	pass
	

func hide_blur():
	$BlurEffect.visible = false
	pass


func show_win_splash():
	win_splash = WinSplash.instantiate()
	win_splash.scale = Vector2(0,0)
	win_splash.position = self.size / 2 - win_splash.pivot_offset
	win_splash.z_index = Globals.INDEX_ORDER_BLUR
	add_child(win_splash)
	win_splash.show_anim(stars)
	pass


func hide_win_splash():
	win_splash.hide_anim()
	pass
