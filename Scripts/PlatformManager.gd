extends Node

@export var basicPlatform: PackedScene
@export var bouncyPlatform: PackedScene
@export var movingPlatform: PackedScene
@export var fallingPlatform: PackedScene

func spawnPlatform(platformType: String, position: Vector2) -> void:
	var platform: Node2D
	
	match platformType:
		"basic":
			platform = basicPlatform.instantiate()
		"bouncy":
			platform = bouncyPlatform.instantiate()
		"moving":
			platform = movingPlatform.instantiate()
		"falling": 
			platform = fallingPlatform.instantiate()
		_:
			platform = basicPlatform.instantiate()
	
	platform.position = position
	owner.add_child(platform)
