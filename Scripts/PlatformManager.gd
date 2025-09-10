extends Node

@export var basicPlatform: PackedScene
@export var bouncyPlatform: PackedScene
@export var movingPlatform: PackedScene
@export var fallingPlatform: PackedScene
@export var stawberry: PackedScene

var lastPlatform: Node2D
var platforms: Array = []
const MAX_PLATFORMS: int = 7
var platformCount: int = 0;

func spawn_platform(platform_type: String, position: Vector2) -> void:
	var platform: Node2D
	var berry : Node2D

	match platform_type:
		"basic":
			platform = basicPlatform.instantiate()
			berry = stawberry.instantiate()
			platformCount += 1
		"bouncy":
			platform = bouncyPlatform.instantiate()
		"moving":
			platform = movingPlatform.instantiate()
		"falling":
			platform = fallingPlatform.instantiate()
		_:
			platform = basicPlatform.instantiate()
	
	platform.position = position
	#berry.position = position
	add_child(platform)
	platform.add_child(berry)
	platforms.append(platform)
	lastPlatform = platform
	

func _process(_delta: float) -> void:
	print(platforms.size())
	while platformCount < MAX_PLATFORMS:
		var offset_x = randi_range(-800, 800)  
		var offset_y = randi_range(-150, -200)
		
		var pos: Vector2
		if lastPlatform:
			pos = lastPlatform.position + Vector2(offset_x, offset_y)
		else:
			pos = Vector2(600, 800)

		spawn_platform("basic", pos)


func _on_rat_horde_platform_destroy() -> void:
	platformCount -= 1
