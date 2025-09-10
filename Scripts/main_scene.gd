extends Node2D

var music_playing: bool = true
@onready var hud_settings = $Hud/SettingsHud

func _ready() -> void:
	hud_settings.connect("settings_closed", Callable(self, "settings_closed"))
	hud_settings.connect("music_muted", Callable(self, "mute_music"))
	hud_settings.connect("music_unmuted", Callable(self, "unmute_music"))
	hud_settings.connect("deathsound_muted", Callable(self, "mute_deathsound"))
	hud_settings.connect("deathsound_unmuted", Callable(self, "unmute_deathsound"))
	$Hud.connect("died", Callable(self, "game_over"))
	$Camera2D/Music.play()

func new_game() -> void:
	if not music_playing and not GLOBAL.checkbox_music_mute:
		$Camera2D/Music.play()
		music_playing = true

func restart_game() -> void:
	$Camera2D/Music.stop(); music_playing = false
	await get_tree().create_timer(1.5).timeout
	if not GLOBAL.checkbox_music_mute:
		$Camera2D/Music.play(); music_playing = true

#TODO: connect to 'hit' signal from character model
func game_over() -> void:
	$Camera2D/Music.stop();
	music_playing = false

func settings_open() -> void:
	pass

func settings_closed() -> void:
	pass

func pause_game() -> void:
	$Camera2D/Music.stop(); music_playing = false

func unpause_game() -> void:
	if not GLOBAL.checkbox_music_mute:
		$Camera2D/Music.play()
		music_playing = true

#TODO: connect to strawberry eaten signal to play
func play_strawberry_sound() -> void:
	var temp = $Camera2D/Music.get_playback_position()
	$Camera2D/Music.stop()
	$Camera2D/EatStrawberrySound.play()
	$Camera2D/Music.play(temp)

func mute_music() -> void:
	$Camera2D/Music.volume_db = -80

func unmute_music() -> void:
	$Camera2D/Music.volume_db = 0

func mute_deathsound() -> void:
	$Camera2D/DeathSound.volume_db = -80
	$Hud/DeathVoice.volume_db = -80
	
func unmute_deathsound() -> void:
	$Camera2D/DeathSound.volume_db = 0


func _on_player_collected_strawberry() -> void:
	play_strawberry_sound()
