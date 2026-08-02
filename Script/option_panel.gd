extends Panel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SoundOption/MasterSlider.value = db_to_linear(AudioServer.get_bus_volume_linear(0))
	$SoundOption/SFXSlider.value = db_to_linear(AudioServer.get_bus_volume_linear(1))
	$SoundOption/MusicSlider.value = db_to_linear(AudioServer.get_bus_volume_linear(2))

func _on_master_slider_mouse_exited() -> void:
	release_focus()


func _on_sfx_slider_mouse_exited() -> void:
	release_focus()


func _on_music_slider_mouse_exited() -> void:
	release_focus()
