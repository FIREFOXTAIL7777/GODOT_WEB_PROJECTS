extends Node2D

@onready var lootMusic: AudioStreamPlayer2D = $AudioStreamPlayer2D

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
				child.body_exited.connect(on_plate_body_exited.bind(child))
				
			if child is Sprite2D:
				magical_logs.append(child)
			
		max_score = plates.size()
		


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Place"):
		check_plate()


func on_plate_body_entered(body: Node2D, plate: Area2D) -> void:
	if !body.is_in_group("Box"):
		return
		
	plate.current_box = body
		
	if plate.activated:
		return


func on_plate_body_exited(body, plate) -> void:
	if body == plate.current_box:
		plate.current_box = null


func check_plate() -> void:
	
	for plate in plates:

		if plate.current_box == null:
			continue
		
		if plate.activated:
			continue
		
		plate.activated = true
		
		var index: = plates.find(plate)
		
		if index != -1:
			magical_logs[index].show()
		
		remove_box(plate.current_box, plate)
		lootMusic.play()


func remove_box(body, plate: Area2D) -> void:
	body.call_deferred("queue_free")
	
	score += 1
	
	plate.set_deferred("monitoring", false)
	
	if score >= max_score:
		await lootMusic.finished
		get_tree().change_scene_to_file("res://Scene/UI/Win_screen.tscn")
