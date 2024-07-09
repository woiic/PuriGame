extends Area2D

var speed = 400
signal hit
@onready var sprite_2d: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if $AnimationPlayer:
		$AnimationPlayer.current_animation = "walk"
		if Input.is_action_pressed("move_right") and Input.is_action_pressed("dash"):
			velocity.x += 2
			$Sprite2D.flip_h = false
		elif Input.is_action_pressed("move_left") and Input.is_action_pressed("dash"):
			velocity.x -= 2
			$Sprite2D.flip_h = true
		elif Input.is_action_pressed("move_right"):
			velocity.x += 1
			$Sprite2D.flip_h = false
		elif Input.is_action_pressed("move_left"):
			velocity.x -= 1
			$Sprite2D.flip_h = true
		else:
			$AnimationPlayer.current_animation = "idle"
		velocity *= speed
		var new_position = get_position()
		var screen_size = get_viewport().get_visible_rect().size
		new_position += velocity * delta
		new_position.x = clamp(new_position.x, 0, screen_size.x)
		set_position(new_position)

func _on_area_entered(area):
	var type = area.pickable_type
	emit_signal("hit", type)
	area.queue_free()
