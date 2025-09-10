extends Node

@export var basicPlatform: PackedScene
@export var bouncyPlatform: PackedScene
@export var movingPlatform: PackedScene
@export var fallingPlatform: PackedScene
@export var stawberry: PackedScene

var lastPlatform: Node2D
const MAX_PLATFORMS: int = 7
var platformCount: int = 0;
var TIMER_TIME = 1
var timer

func _ready() -> void:
		timer = TIMER_TIME
		var initialPlatforms = 0
		while initialPlatforms < 7:
			var offset_x = randi_range(-800, 800)  
			var offset_y = randi_range(-150, -200)
			
			var pos: Vector2
			if lastPlatform:
				pos = _getPlatformPosition(lastPlatform.position)
			else:
				pos = Vector2(600, 800)
				
			spawn_platform("basic", pos)
			initialPlatforms += 1

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
	lastPlatform = platform
	

func _process(_delta: float) -> void:
	
	if timer < 0.1:
		print("Making a platform")
		var offset_x = randi_range(-800, 800)  
		var offset_y = randi_range(-150, -200)
		
		var pos: Vector2
		if lastPlatform:
			pos = _getPlatformPosition(lastPlatform.position)
		else:
			pos = Vector2(600, 800)
			
		spawn_platform("basic", pos)
		timer = TIMER_TIME
	else:
		
		timer -= _delta
		print("changin timer " + str(timer))


func _on_rat_horde_platform_destroy() -> void:
	platformCount -= 1
	
func _getPlatformPosition(oldPos: Vector2) -> Vector2:
	var offset_y = randi_range(230, 320)
	var xPos: float
	var safe = false

	xPos = randi_range(200,1800)

	return Vector2(xPos, oldPos.y - offset_y)
