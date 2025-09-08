extends Node2D

var music_playing: bool = true

func _ready() -> void:
	$Music.play()

func new_game() -> void:
	if not music_playing:
		$Music.play()
		music_playing = true

func restart_game() -> void:
	$Music.stop()
	await get_tree().create_timer(1.5).timeout
	$Music.play()

#TODO: connect to 'hit' signal from character model
func game_over() -> void:
	$Music.stop(); music_playing = false
	$DeathSound.play()

func settings_open() -> void:
	$Music.stop(); music_playing = false

func settings_closed() -> void:
	$Music.play(); music_playing = true

func pause_game() -> void:
	$Music.stop(); music_playing = false

func unpause_game() -> void:
	$Music.play(); music_playing = true
