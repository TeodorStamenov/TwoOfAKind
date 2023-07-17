extends TextureRect
class_name WinSplash

var _stars = null
	
	
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
	var delay = 0.2
	var star_idx = 1
	
	for star in _stars:
		if star.is_full():
			var star_str = "Stars/Star" + str(star_idx)  
			get_tree().create_timer(delay).timeout.connect(drop_star.bind(get_node(star_str)))
			delay += 0.4
			star_idx += 1
	pass
	

func show_anim(stars):
	$Animations.play("FadeIn")
	_stars = stars
	pass
	
	
func hide_anim():
	$Animations.play("FadeOut")
	pass
	
	
func _on_animations_animation_finished(anim_name):
	if anim_name == "FadeIn":
		fill_stars()
	pass
