extends CanvasLayer

signal settings_closed
signal music_muted
signal music_unmuted
signal deathsound_muted
signal deathsound_unmuted

const master_bus_index: int = 0

func _on_exit_button_pressed() -> void:
	settings_closed.emit()

func _on_music_checkbox_toggled(toggled_on: bool) -> void:
	GLOBAL.checkbox_music_mute = toggled_on
	if toggled_on: music_muted.emit()
	else: music_unmuted.emit()

func _on_death_sound_checkbox_toggled(toggled_on: bool) -> void:
	GLOBAL.checkbox_deathsound_mute = toggled_on
	if toggled_on: deathsound_muted.emit()
	else: deathsound_unmuted.emit()

func _on_master_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(master_bus_index, linear_to_db(value))
