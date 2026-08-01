extends Node2D

@onready var label: Label = $Label

@onready var magical_log_1: Node2D = $Point_Entity/Point_1/Magical_log_1
@onready var magical_log_2: Node2D = $Point_Entity/Point_2/Magical_log_2

const FILE_PATH = "res://Scene/Levels/level_"
var score: = 0

func _on_plate_1_body_entered(body: Node2D) -> void:
	remove_body(body)
	show_log_1(body)

func _on_plate_2_body_entered(body: Node2D) -> void:
	remove_body(body)
	show_log_2(body)

func Set_score() -> void:
	score += 1
	label.set_text(str(score))

func show_log_1(body) -> void:
	if body is RigidBody2D:
		magical_log_1.show()
	
func show_log_2(body) -> void:
	if body is RigidBody2D:
		magical_log_2.show()

func remove_body(body) -> void:
	if body is RigidBody2D:
		body.queue_free()
		Set_score()

func _on_magic_grass_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var current_scene_file = get_tree().current_scene.scene_file_path
		var next_level_number = current_scene_file.to_int() + 1
		
		var next_level_path = FILE_PATH + str(next_level_number) + ".tscn"
		get_tree().change_scene_to_file(next_level_path)
