extends CharacterBody2D

@onready var player: CharacterBody2D = $"."
@onready var bounds: Bounds = %Bounds

const GRID = 16

var next_direction = Vector2(0,0)
var current_direction = Vector2(0,0) 
var moving = false

var animation_speed = 4
var horizontal_input
var vertical_input 

@onready var ray = $RayCast2D


func _ready():
	position.snapped(Vector2.ONE * GRID)
	position += Vector2.ONE * GRID/2


func _process(_delta: float):
	horizontal_input = Input.get_axis("ui_left", "ui_right")
	vertical_input = Input.get_axis("ui_up", "ui_down")

	if current_direction.x == 0:
		if horizontal_input > 0:
			next_direction = Vector2.RIGHT
		if horizontal_input < 0:
			next_direction = Vector2.LEFT

	if current_direction.y == 0:
		if vertical_input > 0:
			next_direction = Vector2.DOWN
		if vertical_input < 0:
			next_direction = Vector2.UP


func _physics_process(_delta: float) -> void:
	var new_pos: Vector2 = player.position * next_direction
	new_pos = bounds.wrap_vector(player.position)
	player.position = new_pos

	if not moving:
		move()
	

func move():
	ray.target_position = next_direction * GRID
	ray.force_raycast_update()
	if !ray.is_colliding():
		var tween = create_tween()
		tween.tween_property(self, "position",
			position + next_direction * GRID, 1.0/animation_speed).set_trans(Tween.TRANS_LINEAR)
		moving = true
		current_direction = next_direction
		await tween.finished
		moving = false
