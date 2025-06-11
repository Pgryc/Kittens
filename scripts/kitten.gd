extends CharacterBody2D

@onready var bounds: Bounds = %Bounds

var next_kitten = null
var previous_kitten = null
var kitten_scene = preload("res://scenes/kitten.tscn")
const player_cat_mother = preload("res://scripts/player.gd")

func _ready(): 
	previous_kitten = get_node("/root/Game/Player")
	previous_kitten.next_kitten = self

	add_transition_sprites()

func add_transition_sprites():
	var sprite = get_node("AnimatedSprite2D")

	var top_sprite = sprite.duplicate()
	var bottom_sprite = sprite.duplicate()
	var left_sprite = sprite.duplicate()
	var right_sprite = sprite.duplicate()

	top_sprite.position.y -= 160
	bottom_sprite.position.y += 160
	left_sprite.position.x -= 320 - 32
	right_sprite.position.x += 320 - 32

	self.add_child(top_sprite)
	self.add_child(bottom_sprite)
	self.add_child(left_sprite)
	self.add_child(right_sprite)


func _physics_process(_delta: float) -> void:
	var new_pos: Vector2 = position
	new_pos = bounds.wrap_vector(position)
	position = new_pos


func move_to(next_position):
	var tween = create_tween()
	tween.tween_property(self, "position",
		next_position, 1.0/previous_kitten.animation_speed).set_trans(Tween.TRANS_LINEAR)
	
	if next_kitten != null:
		next_kitten.move_to(position)


#func add_kitten():
	#randomize()
	#var kitten_instance = kitten_scene.instantiate()
	#kitten_instance.position.snapped(Vector2.ONE * player_cat_mother.GRID)
	#kitten_instance.position = Vector2(randi_range(bounds.upper_left.position.x, bounds.lower_right.position.x), randi_range(bounds.lower_right.position.y, bounds.upper_left.position.y))
	#kitten_instance.position += Vector2.ONE * player_cat_mother.GRID/2
	#add_child(kitten_instance)
	#wait_time = randi_range(3,4)
	#timer.start()
