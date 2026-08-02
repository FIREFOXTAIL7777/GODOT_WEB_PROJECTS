extends Control

func _process(_delta: float) -> void:
	testEsc()
	
func _ready() -> void:
	$AnimationPlayer.play("RESET")

func resume() -> void:
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")

func pause() -> void:
	get_tree().paused = true
	$AnimationPlayer.play("blur")


func testEsc() -> void:
	if Input.is_action_just_pressed("Esc") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("Esc") and get_tree().paused:
		resume()


func _on_restart_pressed() -> void:
	resume()
	get_tree().reload_current_scene()


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_resume_pressed() -> void:
	resume()


func _on_main_menu_pressed() -> void:
	resume()
	get_tree().change_scene_to_file("res://Scene/UI/Main_menu.tscn")
