extends CharacterBody2D

const GRAVITY := 20.0
const JUMP_FORCE := -900.0   # negative = upward in Godot
var speed = 50
var deceleration = 6
var maxXVelocity = 1500
# Max height ~20000

func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY
	if Input.is_action_pressed("ui_left", true):
		velocity.x -= speed
		if(velocity.x < -maxXVelocity):
			velocity.x = -maxXVelocity + 40
	if Input.is_action_pressed("ui_right", true):
		velocity.x += speed
		if(velocity.x > maxXVelocity):
			velocity.x = maxXVelocity - 40
	velocity.x = move_toward(velocity.x, 0, deceleration)

	if is_on_floor() and velocity.y > 0:
		velocity.y = JUMP_FORCE

	move_and_slide()
