extends CanvasLayer

signal settings_closed

const master_bus_index: int = 0

func _on_exit_button_pressed() -> void:
	settings_closed.emit()

func _on_music_checkbox_toggled(toggled_on: bool) -> void:
	GLOBAL.checkbox_music_mute = toggled_on

func _on_death_sound_checkbox_toggled(toggled_on: bool) -> void:
	GLOBAL.checkbox_deathsound_mute = toggled_on

func _on_master_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(master_bus_index, linear_to_db(value))
