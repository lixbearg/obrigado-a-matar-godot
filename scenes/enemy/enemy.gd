extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var money : float = randf_range(1.0, 5.0)


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()


func die():
	GameManager.update_money(money)
	queue_free()
