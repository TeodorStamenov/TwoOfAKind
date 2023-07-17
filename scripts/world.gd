extends Control
class_name World


signal player_win
signal player_loss
signal splash_timeout

@onready var WinSplash = preload("res://scenes/win_splash.tscn")
@onready var Star = preload("res://scenes/star.tscn")

@onready var _board = $BoardScn as Board
@onready var _info_panel = $InfoPanelScn as InfoPanel
@onready var _stars = _info_panel.stars

var pairs = Globals.NUMBER_OF_CARDS / 2
var points = 0
var current_star_idx = 0
var current_pair = 0

var target_star = null
var win_splash = null
	

func setup(data: LevelData):
	_setup()
	_board.setup()
	_info_panel.setup(data)
	
	_board.match_pairs_signal.connect(_on_board_match_pairs)
	_info_panel.player_timer.time_elapsed.connect(_on_player_timer_elapsed)
	pass


func start_game():
	_info_panel.start_player_timer()
	pass


func _setup():
	current_pair = 0
	current_star_idx = 0
	target_star = _stars[current_star_idx]
	points = target_star.max_points / Globals.NUMBER_OF_CARDS
	pass


func _on_player_timer_elapsed():
	emit_signal("player_loss")
	pass
	
	
func _calculate_target_star():
	if target_star.current_points >= target_star.max_points:
		current_star_idx += 1
		if current_star_idx < _stars.size():
			target_star = _stars[current_star_idx]
	pass


func _on_board_match_pairs():
	_calculate_target_star()
	
	_board.start_cards_vanish()
	_board.start_cards_explosion()
	
	_spawn_flying_star(_board.first_card.face.global_position, target_star.position, 1)
	_spawn_flying_star(_board.second_card.face.global_position, target_star.position, 2)

	_board.reset_cards()
	
	current_pair += 1
	if current_pair == pairs:
		get_tree().create_timer(2).timeout.connect(emit_signal.bind("player_win"))
	pass


func _spawn_flying_star(start_pos, end_pos, mask):
	var flying_star = Star.instantiate()
	add_child(flying_star)
	flying_star.set_collision_mask_value(mask, true)
	flying_star.z_index = 2
	flying_star.global_position = start_pos
	_start_star_fly_animation(flying_star, end_pos)
	pass


func _start_star_fly_animation(star, end_pos):
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
	if points_left > 0 and current_star_idx < (_stars.size() - 1):
		_stars[current_star_idx+1].fill_extend(points_left)
	pass


func _on_splash_timer_timeout():
	emit_signal("splash_timeout")
	pass


func next_level():
	_info_panel.next_level()
	pass


func stop_player_timer():
	_info_panel.stop_player_timer()
	pass


func blur_screen():
	$BlurEffect.visible = true
	pass
	

func blur_screen_remove():
	$BlurEffect.visible = false
	pass


func start_splash_timer():
	$SplashTimer.start()
	pass


func win_splash_show():
	win_splash = WinSplash.instantiate()
	win_splash.scale = Vector2(0,0)
	win_splash.position = self.size / 2 - win_splash.pivot_offset
	win_splash.z_index = Globals.INDEX_ORDER_BLUR
	add_child(win_splash)
	win_splash.show_anim(_stars)
	pass


func show_loss_splash():
	#implement
	pass


func win_splash_hide():
	win_splash.hide_anim()
	pass
