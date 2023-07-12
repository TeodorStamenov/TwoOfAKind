extends TextureRect


func _ready():
	pass
	
	
func drop_star(target_star):
	var star = TextureRect.new()
	add_child(star)
	star.set_texture(load("res://assets/ui/upgrade/star.png"))
	star.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	star.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	star.set_size(target_star.size)
	star.pivot_offset = star.size / 2
	star.scale = Vector2(4,4)
	star.z_index = 3
	star.set_global_position(target_star.global_position)
	
	var tween = create_tween()
	tween.parallel().tween_property(star, "scale", target_star.scale, 0.4).set_ease(Tween.EASE_IN)
	tween.parallel().tween_property(star, "z_index", target_star.z_index, 0.6).set_ease(Tween.EASE_IN)
	pass


func fill_stars():
	get_tree().create_timer(0.2).timeout.connect(drop_star.bind($Stars/Star1))
	get_tree().create_timer(0.6).timeout.connect(drop_star.bind($Stars/Star2))
	get_tree().create_timer(1.0).timeout.connect(drop_star.bind($Stars/Star3))
	pass
	

func start_appear_anim():
	$Animations.play("FadeIn")
	pass
	
	
func _on_animations_animation_finished(anim_name):
	if anim_name == "FadeIn":
		fill_stars()
	pass
