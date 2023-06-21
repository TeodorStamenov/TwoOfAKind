extends Area2D


@onready var foreground = $ForegroundCtrl
@onready var max_points = foreground.size.x
@onready var current_points = 0


func shake():
	var spring = 200.0
	var damp = 10.0
	var velocity = 15.0
	
	DampedOscillator.animate(self, "scale", spring, damp, velocity, 0.75)
	pass

func fill(value):
	var tween_fill = create_tween()
	tween_fill.tween_property($ForegroundCtrl, "size:x", value, 0.5).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	pass
	

func fill_extend(value):
	current_points += value
	fill(current_points)
	pass
	

func take_hit(value):
	current_points += value
	var points_left = 0
	if current_points > max_points:
		points_left = current_points - max_points
		current_points = max_points
		
	shake()
	fill(current_points)
	
	return points_left


func start_ghost():
	$GhostTimer.start()
	pass

func _on_ghost_timer_timeout():
	var ghost_star = self.duplicate()
	get_parent().add_child(ghost_star)
	ghost_star.get_node("CollisionShape2D").set_disabled(true)
	ghost_star.z_index = 0
	ghost_star.scale = Vector2(0.2, 0.2)
	
	var tween = get_parent().create_tween()
	tween.parallel().tween_property(ghost_star, "modulate:a", 0, 1)
	tween.parallel().tween_property(ghost_star, "scale", Vector2(0.0, 0.0), 1)
	tween.tween_callback(ghost_star.queue_free)
	pass


func _on_area_entered(area):
	$GhostTimer.stop()
	pass
