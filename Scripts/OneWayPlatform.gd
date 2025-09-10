extends StaticBody2D

@onready var collider: CollisionShape2D = $CollisionShape2D
var player: CharacterBody2D
var yOffset = 90

func _process(_delta: float) -> void:
	player = get_node("/root/MainScene/Player")
	if not player:
		return
	
	if player.global_position.y < global_position.y - yOffset:
		collider.disabled = false
		print("Player global position:", player.global_position.y)
		print("Platform position:", global_position.y)
	else:
		collider.disabled = true
		print("Player global position:", player.global_position.y)
		print("Platform position:", global_position.y)
