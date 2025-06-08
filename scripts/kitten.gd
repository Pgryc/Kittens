extends CharacterBody2D

@onready var bounds: Bounds = %Bounds

var next_kitten = null
var previous_kitten = null

func _ready(): 
	previous_kitten = get_node("/root/Game/Player")
	previous_kitten.next_kitten = self


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
