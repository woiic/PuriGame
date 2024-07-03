extends CanvasLayer

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	$Points.hide()
	$GameOver.hide()
	$Init.show()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed():
	emit_signal("start_game")
	$GameOver.hide()
	$Init.hide()
	$Points.show()

func _on_node_2d_game_over(total_score):
	$Init.hide()
	$Points.hide()
	$GameOver.show()
	$GameOver/Score.text = str(total_score)

func _on_button_3_pressed():
	$GameOver.hide()
	$Points.hide()
	$Init.show()
	$GameOver/Score.text = ""

func _on_button_2_pressed():
	emit_signal("start_game")
	$GameOver.hide()
	$Init.hide()
	$Points.show()

func _on_node_2d_update_hearts(hearts):
	$Points/total3/Label2.text = str(hearts)

func _on_node_2d_update_partial_score(score):
	$Points/total2/Label2.text = str(score)

func _on_node_2d_update_total_score(score):
	$Points/total/Label2.text = str(score)
