extends Control

@onready var main_buttons: VBoxContainer = $MainButtons
@onready var option_panel: Panel = $OptionPanel

func _ready() -> void:
	option_panel.visible = false

func back_option() -> void:
	main_buttons.visible = true
	option_panel.visible = false

func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/Levels/level_1.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_option_pressed() -> void:
	main_buttons.visible = false
	option_panel.visible = true


func _on_back_option_pressed() -> void:
	back_option()


func _on_apply_pressed() -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db($OptionPanel/SoundOption/MasterSlider.value))
	AudioServer.set_bus_volume_db(1, linear_to_db($OptionPanel/SoundOption/SFXSlider.value))
	AudioServer.set_bus_volume_db(2, linear_to_db($OptionPanel/SoundOption/MusicSlider.value))
