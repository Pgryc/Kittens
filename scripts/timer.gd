extends Timer

var kitten_scene = preload("res://scenes/new_kitten.tscn")
@onready var bounds: Bounds = %Bounds
const player_cat_mother = preload("res://scripts/player.gd")
@onready var timer: Timer = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass



func _on_timeout() -> void:
	print("hi")
	add_kitten()
	
func add_kitten():
	randomize()
	var kitten_instance = kitten_scene.instantiate()

	kitten_instance.position.snapped(Vector2.ONE * player_cat_mother.GRID)
	kitten_instance.position = Vector2(randi_range(bounds.upper_left.position.x, bounds.lower_right.position.x), randi_range(bounds.lower_right.position.y, bounds.upper_left.position.y))
	kitten_instance.position += Vector2.ONE * player_cat_mother.GRID/2
	add_child(kitten_instance)
	wait_time = randi_range(3,4)
	timer.start()
