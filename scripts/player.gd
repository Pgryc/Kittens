extends CharacterBody2D


const SPEED = 150.0
const DIRECTION = Vector2(0,0)
var next_direction = Vector2(0,0)
var frame = 0


func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var horizontal_input := Input.get_axis("ui_left", "ui_right")
	var vertical_input := Input.get_axis("ui_up", "ui_down")

	if DIRECTION.x == 0:
		if horizontal_input > 0:
			next_direction = Vector2(1,0)
		if horizontal_input < 0:
			next_direction = Vector2(-1,0)

	if DIRECTION.y == 0:
		if vertical_input > 0:
			next_direction = Vector2(0,1)
		if vertical_input < 0:
			next_direction = Vector2(0,-1)

	if frame % 10 == 0:
		velocity.x = next_direction.x * SPEED
		velocity.y = next_direction.y * SPEED

	move_and_slide()
	frame += 1
	##position = bounds.wrap_vector(new_pos)
