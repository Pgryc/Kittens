extends Area2D


	
	
func _on_body_entered(body: Node2D) -> void:
	if body.get_class() == "CharacterBody2D" and body.has_method('add_kitten'):
		body.add_kitten()
  #TODO: this will immediately delete node spawned on child kitten without handling it in any way
	self.call_deferred('free')
	print("+1")
