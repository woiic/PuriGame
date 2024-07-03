extends Area2D

signal loss_ball

var pickable_type = 0
@export var velocity = 200
var limit = 700

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	var delta_y = delta * velocity
	var new_position = get_position()
	new_position.y += delta_y
	set_position(new_position)
	if (new_position.y > limit):
		if (pickable_type == 3):
			emit_signal("loss_ball")
		queue_free()

func set_type(type):
	pickable_type = type
	if (type == 0):
		$Sprite2D.texture = load("res://assets/pixel_pack/medicine.png")
		$Sprite2D.scale.x = 0.4
		$Sprite2D.scale.y = 0.4
	elif (type == 1):
		$Sprite2D.texture = load("res://assets/pixel_pack/heart.png")
		$Sprite2D.scale.x = 0.2
		$Sprite2D.scale.y = 0.2
	elif (type == 2):
		$Sprite2D.texture = load("res://assets/pixel_pack/bomb.png")
		$Sprite2D.scale.x = 0.2
		$Sprite2D.scale.y = 0.2
	else:
		$Sprite2D.texture = load("res://assets/TinyTails Asset Pack/pngs/ball.png")
		$Sprite2D.scale.x = 2
		$Sprite2D.scale.y = 2
