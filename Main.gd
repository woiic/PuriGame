extends Node2D

signal game_over
signal update_partial_score
signal update_total_score
signal update_hearts

@export var pickable_scene: PackedScene
var saved_score = 0
var score = 0
var hearts = 5
var pickable_probs = [
	0.05,
	0.1, #0.05
	0.3, #0.2
	1.0  #0.5
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pickable_timer_timeout():
	# Create a new instance of the Mob scene.
	var pickable = pickable_scene.instantiate()
	
	# Get random x position
	var screenSize = get_viewport().get_visible_rect().size
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var rndX = rng.randi_range(0, screenSize.x)

	# Set the mob's position to a random location.
	pickable.position.x = rndX
	pickable.position.y = -100
	
	# Set type
	# medicina = 5%
	# heart = 5%
	# bomba = 20%
	# pelota = 70%
	var rand_number = rng.randf()
	var new_type = 0
	for i in range(4):
		if rand_number <= pickable_probs[i]:
			new_type = i
			break
			
	pickable.set_type(new_type)

	# Spawn the mob by adding it to the Main scene.
	$Pickables.add_child(pickable)
	pickable.connect("loss_ball", _on_loss_ball)


func _on_player_hit(type):
	if type == 0:
		saved_score += score
		score = 0
		emit_signal("update_partial_score", score)
		emit_signal("update_total_score", saved_score)
	elif type == 1:
		hearts = min(hearts + 1, 3)
		emit_signal("update_hearts", hearts)		
	elif type == 2:
		score = 0
		emit_signal("update_partial_score", score)
		hearts -= 1
		emit_signal("update_hearts", hearts)		
		if hearts <= 0:
			_on_game_over()
	else:
		score += 1
		emit_signal("update_partial_score", score)
		
func _on_loss_ball():
	hearts -= 1
	emit_signal("update_hearts", hearts)
	if hearts <= 0:
		_on_game_over()

func _on_game_over():
	var pickables = $Pickables.get_children()
	for pickable in pickables:
		pickable.queue_free()
	$Player.hide()
	$PickableTimer.stop()
	emit_signal("game_over", saved_score + score)
	GlobalEndGame(saved_score + score)
	hearts = 5
	saved_score = 0
	score = 0

func _on_hud_start_game():
	$PickableTimer.start()
	$Player.show()
	emit_signal("update_hearts", hearts)
	emit_signal("update_partial_score", score)
	emit_signal("update_total_score", saved_score)

## -------------------------------------------------- metodos API -------------------------------------------------- ##

#var Global = false

func GlobalCloseGame():
	if Global:
		return Global.closeGame()

func GlobalEndGame(score):
	if Global:
		return Global.game_over(score)

