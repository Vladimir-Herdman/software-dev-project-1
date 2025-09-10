extends Area2D

var speed = -150
var game_started = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_horde(delta)

func move_horde(delta):
	if game_started:
		position.y += delta * speed

func _on_hud_start_pressed() -> void:
	game_started = true


func _on_destructor_body_entered(body: Node2D) -> void:
	body.queue_free()
	print("freed something")


func _on_destructor_area_entered(area: Area2D) -> void:
	area.owner.queue_free()
	print("freed something")
