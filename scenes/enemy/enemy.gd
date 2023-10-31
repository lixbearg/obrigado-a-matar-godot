class_name Enemy
extends Actor

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var money : float = randf_range(1.0, 5.0)


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()


func die():
	GameManager.update_money(money)
	queue_free()
