class_name PlayerShoot
extends PlayerBaseState


func enter():
	player.weapon.shoot(player.facing_direction, false)


func physics_update(delta : float):
	if !player.is_on_floor():
		transitioned.emit(self, "jump")
	elif Input.get_axis("left", "right"):
		transitioned.emit(self, "walk")
	elif Input.is_action_pressed("crouch"):
		transitioned.emit(self, "crouch")
	else:
		transitioned.emit(self, "idle")
