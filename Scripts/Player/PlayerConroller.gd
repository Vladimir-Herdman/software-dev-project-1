extends CharacterBody2D

const GRAVITY := 20.0
const JUMP_FORCE := -1200.0   # negative = upward in Godot

func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY

	if is_on_floor() and velocity.y > 0:
		velocity.y = JUMP_FORCE

	move_and_slide()
