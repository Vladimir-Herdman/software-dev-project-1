extends CanvasLayer

signal start_pressed #signal that start button pressed
signal restart_pressed
signal settings_open #signal that settings button pressed
signal settings_closed
signal pause #TODO: freeze game somewhere
signal unpause

var paused: bool = false

func hide_huds_except_settings() -> void:
	get_tree().call_group("hud_start", "hide")
	get_tree().call_group("hud_pause", "hide")
	get_tree().call_group("hud_gameover", "hide")

func show_pause_screen() -> void:
	$Message.text = "Paused"
	$PauseButton.text = ">"
	get_tree().call_group("hud_start", "hide")
	get_tree().call_group("hud_pause", "show")
func unshow_pause_screen() -> void:
	get_tree().call_group("hud_pause", "hide")
	$PauseButton.show()
	$PauseButton.text = "||"

#TODO: connect game over func here to 'hit' signal in character from rats, to play game over
func show_game_over() -> void:
	$Message.text = "Game Over"
	$PauseButton.hide()
	get_tree().call_group("hud_gameover", "show")
	
func update_score(score: int) -> void:
	$ScoreLabel.text = str(score)

#signal based functions on their namesakes
func _on_start_button_pressed() -> void:
	#TODO: insert start functionality, just testing right now
	$PauseButton.show()
	get_tree().call_group("hud_start", "hide")
	show_game_over()
	start_pressed.emit()

func _on_pause_button_pressed() -> void:
	if paused:
		unpause.emit()
		unshow_pause_screen()
	else:
		pause.emit()
		show_pause_screen()
		
	paused = not paused

func _on_settings_button_pressed() -> void:
	#TODO: insert settings functionality, just testing right now
	pass

func _on_restart_button_pressed() -> void:
	hide_huds_except_settings()
	$PauseButton.text = "||"
	$PauseButton.show()
	restart_pressed.emit()
