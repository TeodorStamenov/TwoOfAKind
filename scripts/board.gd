extends Control

var first_card = null
var second_card = null

var delay = null
const DELAY_TIME = 0.180

# Called when the node enters the scene tree for the first time.
func _ready():
	_setup_cards()
	_setup_delay()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _input(event):
	if event is InputEventMouseButton:
		if first_card != null and second_card != null:
			event.pressed = false
	pass


func _setup_cards():
	var card_instance = preload("res://scenes/card.tscn").instantiate()
	
	var all_indexes = range(1,20)
	all_indexes.shuffle()
	
	var indexes = all_indexes.slice(0, 6)
	indexes.append_array(indexes.duplicate())
	indexes.shuffle()
	
	for idx in indexes:
		var card = card_instance.duplicate() as Card
		$Cards.add_child(card)
		card.face.set_texture(load("res://assets/landscapes/index" + str(idx) + ".jpg"))
		card.index = idx
		card.on_flip_started_signal.connect(_on_card_flip_started)
		card.on_flip_finish_signal.connect(_on_card_flip_finish)
	pass # Replace with function body.


func _setup_delay():
	delay = Timer.new()
	delay.set_one_shot(true)
	delay.set_wait_time(DELAY_TIME)
	delay.timeout.connect(_on_timeout_complete)
	self.add_child(delay)
	pass


func _on_timeout_complete():
	if first_card.index == second_card.index:
		print("Congrats")
		first_card.get_node("Back").hide()
		second_card.get_node("Back").hide()
	else:
		first_card.get_node("CardAnimations").play("card_hide")
		second_card.get_node("CardAnimations").play("card_hide")
	
	# reset cards
	first_card = null
	second_card = null
	pass


func _on_card_flip_started(card):
	if first_card == null:
		first_card = card
	elif second_card == null:
		second_card = card
	pass
	

func _on_card_flip_finish():
	if first_card != null and second_card != null:
		delay.start()
	pass
