extends CanvasLayer

signal start_pressed #signal that start button pressed
signal restart_pressed
signal settings_open #signal that settings button pressed
signal pause #TODO: freeze game somewhere
signal unpause

var score : int = 0;

class QuotePair:
	var quote_string: String
	var quote_wav: AudioStream
	
	func _init(q_str: String, q_wav: AudioStream) -> void:
		quote_string = q_str
		quote_wav = q_wav

var hasDied: bool = false
var paused: bool = false
var death_text: Array[QuotePair] = [
	QuotePair.new("You've succumbed to the rat horde...",  preload("res://Sounds/you’ve succumbed to rat horde.wav")),
	QuotePair.new("Squeek squeek...", preload("res://Sounds/squeak squeak.wav")),
	QuotePair.new("Hope there's strawberries where you're headed...", preload("res://Sounds/strawberries headed.wav")),
	QuotePair.new("You know what you did...", preload("res://Sounds/you know what did.wav")),
	QuotePair.new("Ratta tat tat...", preload("res://Sounds/ratta tat.wav")),
	QuotePair.new("Good luck in mouse jail...", preload("res://Sounds/mouse jail.wav")),
	QuotePair.new("You've been ratified", preload("res://Sounds/ratified.wav")),
]

func hide_huds_except_settings() -> void:
	get_tree().call_group("hud_start", "hide")
	get_tree().call_group("hud_pause", "hide")
	get_tree().call_group("hud_gameover", "hide")

func show_pause_screen() -> void:
	$Message.text = "Paused"
	$PauseButton.text = ">"
	$RestartButton.disabled = false
	get_tree().call_group("hud_start", "hide")
	get_tree().call_group("hud_pause", "show")
func unshow_pause_screen() -> void:
	get_tree().call_group("hud_pause", "hide")
	$RestartButton.disabled = true
	$PauseButton.show()
	$PauseButton.text = "||"

#TODO: connect game over func here to 'hit' signal in character from rats, to play game over
func show_game_over() -> void:
	var qp: QuotePair = death_text.pick_random()
	var player: AudioStreamPlayer2D = $DeathVoice
	$Message.text = "Game Over"
	
	$DeathMessage.text = qp.quote_string
	player.stream = qp.quote_wav
	player.play()
	
	$PauseButton.hide()
	get_tree().call_group("hud_gameover", "show")
	
func show_settings() -> void:
	get_tree().call_group("hud_settings", "show")
	#$Message.hide()
	#$ScoreLabel.hide()
func hide_settings() -> void:
	get_tree().call_group("hud_settings", "hide")
	$ScoreLabel.show()
	
func update_score(score: int) -> void:
	$ScoreLabel.text = "Score: " + str(score)

#signal based functions on their namesakes
func _on_start_button_pressed() -> void:
	#TODO: insert start functionality, just testing right now
	$PauseButton.show()
	get_tree().call_group("hud_start", "hide")
	#show_game_over()
	start_pressed.emit()

func _on_pause_button_pressed() -> void:
	if paused:
		get_tree().paused = false
		unpause.emit()
		unshow_pause_screen()
	else:
		get_tree().paused = true
		pause.emit()
		show_pause_screen()
		
	paused = not paused

func _on_settings_button_pressed() -> void:
	settings_open.emit()
	show_settings()

func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	paused = false

	get_tree().reload_current_scene()

# Activates when player touches rat body
func _on_rat_horde_body_entered(body: Node2D) -> void:
	# Makes it so it only runs once
	if !hasDied:
		show_game_over()
	hasDied = true

func _on_player_collected_strawberry() -> void:
	score += 1
	update_score(score)
