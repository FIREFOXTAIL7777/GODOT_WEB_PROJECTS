extends CharacterBody2D
	
var push_force : = 200

func push(direction: Vector2) -> void:
	velocity = direction * push_force
	move_and_slide()
	
