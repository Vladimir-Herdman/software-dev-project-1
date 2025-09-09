extends Node2D

var music_playing: bool = true
@onready var hud_settings = $Hud/SettingsHud

func _ready() -> void:
	hud_settings.connect("settings_closed", Callable(self, "settings_closed"))
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
	print(GLOBAL.checkbox_deathsound_mute)

func settings_closed() -> void:
	pass

func pause_game() -> void:
	$Music.stop(); music_playing = false

func unpause_game() -> void:
	$Music.play(); music_playing = true

#TODO: connect to strawberry eaten signal to play
func play_strawberry_sound():
	$Music.stop()
	$EatStrawberrySound.play()
