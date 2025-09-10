extends CollisionShape2D

@export var strawberry: PackedScene

var x : Vector2 = Vector2(0,-20)

func spawn_strawberry() -> void:
	var berry : RigidBody2D
	berry = strawberry.instantiate()
	berry.position = Vector2(randi_range(-800,800), 0)
	

func _process(delta: float) -> void:
	spawn_strawberry()
