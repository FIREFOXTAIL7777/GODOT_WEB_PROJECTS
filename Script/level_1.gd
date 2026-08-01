extends Node2D

const FILE_PATH: = "res://Scene/Levels/level_"

var score: = 0
var max_score: = 0

var plates: Array[Area2D] = []
var magical_logs: Array[Sprite2D] = []

func _ready() -> void:
	var point_entity = $"Y-sort_enabled/Point_Entity"
	
	for point in point_entity.get_children():
		
		for child in point.get_children():
			
			if child is Area2D:
				plates.append(child)
				child.body_entered.connect(on_plate_body_entered.bind(child))
			
			if child is Sprite2D:
				magical_logs.append(child)
			
		max_score = plates.size()


func on_plate_body_entered(body: Node2D, plate: Area2D) -> void:
	if !body.is_in_group("Box"):
		return
		
	if plate.activated:
		return
	
	plate.activated = true
	
	var index: = plates.find(plate)
	
	if index != -1:
		magical_logs[index].show()
	
	remove_box(body, plate)


func remove_box(body, plate: Area2D) -> void:
	body.call_deferred("queue_free")
	
	score += 1
	
	plate.set_deferred("monitoring", false)
	
	if score >= max_score:
		next_level()


func next_level() -> void:
	await get_tree().process_frame
	var current_scene_file = get_tree().current_scene.scene_file_path
	var file_name = current_scene_file.get_file().get_basename() # "level_1"
	var current_level_number = file_name.trim_prefix("level_").to_int()
	var next_level_number = current_level_number + 1

	var next_level_path = FILE_PATH + str(next_level_number) + ".tscn"
	get_tree().change_scene_to_file(next_level_path)
