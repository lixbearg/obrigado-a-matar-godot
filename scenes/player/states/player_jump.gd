class_name PlayerJump
extends PlayerBaseState


func enter():
	skin.play("jump")
	player.jump()


func physics_update(delta : float):
	var direction = Input.get_axis("left", "right")
	player.velocity.x = direction * move_speed

	if Input.is_action_just_pressed("shoot"):
		transitioned.emit(self, "shoot")

	if !player.is_on_floor():
		return

	if Input.get_axis("left", "right"):
		transitioned.emit(self, "walk")
	elif Input.is_action_pressed("crouch"):
		transitioned.emit(self, "crouch")
	else:
		transitioned.emit(self, "idle")
