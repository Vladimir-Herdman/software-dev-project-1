extends Node2D

@export var camera: Camera2D
@export var layers: Array[Sprite2D] = []   
@export var speeds: Array[float] = [] 

var last_camera_y: float

func _ready() -> void:
	if camera:
		last_camera_y = camera.global_position.y

func _process(_delta: float) -> void:
	if not camera:
		return

	if camera.global_position.y < last_camera_y:
		var dy = camera.global_position.y - last_camera_y

		for i in layers.size():
			if i < speeds.size():
				layers[i].position.y += dy * speeds[i]

		last_camera_y = camera.global_position.y
