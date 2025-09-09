extends Node

@export var basicPlatform: PackedScene
@export var bouncyPlatform: PackedScene
@export var movingPlatform: PackedScene
@export var fallingPlatform: PackedScene

var lastPlatform: Node2D
var platforms: Array = []
const MAX_PLATFORMS: int = 7

func spawn_platform(platform_type: String, position: Vector2) -> void:
	var platform: Node2D

	match platform_type:
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
	add_child(platform)
	platforms.append(platform)
	lastPlatform = platform


func _process(_delta: float) -> void:
	while platforms.size() < MAX_PLATFORMS:
		var offset_x = randi_range(-800, 800)  
		var offset_y = randi_range(-150, -200)
		
		var pos: Vector2
		if lastPlatform:
			pos = lastPlatform.position + Vector2(offset_x, offset_y)
		else:
			pos = Vector2(600, 800)

		spawn_platform("basic", pos)

	for p in platforms:
		if p.position.y > 1920:
			platforms.erase(p)
			p.queue_free()
