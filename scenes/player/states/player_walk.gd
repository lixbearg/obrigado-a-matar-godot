class_name PlayerWalk
extends PlayerBaseState


func enter():
	skin.play("walk")


func physics_update(delta : float):
	var direction = Input.get_axis("left", "right")
	player.velocity.x = direction * move_speed
	if Input.is_action_just_pressed("jump"):
		transitioned.emit(self, "jump")
	elif Input.is_action_just_pressed("shoot"):
		transitioned.emit(self, "shoot")
	elif direction == 0:
		transitioned.emit(self, "idle")
		return
