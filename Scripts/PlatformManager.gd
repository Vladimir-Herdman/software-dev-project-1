extends Node

@export var basicPlatform: PackedScene
@export var bouncyPlatform: PackedScene
@export var movingPlatform: PackedScene
@export var fallingPlatform: PackedScene
@export var lastPlatform: Node2D

@export var platformCount : int = 1

func spawnPlatform(platformType: String, position: Vector2) -> void:
	var platform: Node2D
	
	match platformType:
		"basic":
			platform = basicPlatform.instantiate()
			lastPlatform = platform
			platformCount += 1
		"bouncy":
			platform = bouncyPlatform.instantiate()
			lastPlatform = platform
			platformCount+=1
		"moving":
			platform = movingPlatform.instantiate()
			lastPlatform = platform
			platformCount+=1
		"falling": 
			platform = fallingPlatform.instantiate()
		_:
			platform = basicPlatform.instantiate()
			lastPlatform = platform
			platformCount+= 1

	
	platform.position = position
	owner.add_child(platform)

func _process(z: float) -> void:

	while(platformCount < 5):
		var pos : Vector2
		pos.x = randi_range(250,1250)
		pos.y = randi_range(400,750)
		pos.y -= lastPlatform.transform.y.length()
		
		spawnPlatform("basic", pos)
