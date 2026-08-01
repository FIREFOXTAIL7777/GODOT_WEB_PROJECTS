extends CharacterBody2D

@onready var player: Sprite2D = $Sprite2D

const SPEED := 230.0
var input_dir: Vector2 = Vector2.ZERO

func _physics_process(_delta: float) -> void:
	input_dir = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_dir * SPEED
	
	if input_dir.x != 0:
		player.flip_h = input_dir.x < 0
	
	move_and_slide()
	
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var body = collision.get_collider()
	
		if body is CharacterBody2D:
			var push_dir = -collision.get_normal()
			body.push(push_dir)
