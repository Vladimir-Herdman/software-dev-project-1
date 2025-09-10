extends Camera2D

@export var player: CharacterBody2D  
var highest_y: float = 10000000

func _ready() -> void:
	if player:
		highest_y = player.global_position.y
		global_position.y = player.global_position.y

func _process(_delta: float) -> void:
	if not player:
		return
	
	if player.global_position.y < highest_y:
		highest_y = player.global_position.y
		global_position.y = highest_y
