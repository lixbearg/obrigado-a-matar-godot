class_name PlayerIdle
extends PlayerBaseState


func enter():
	skin.play("idle")


func physics_update(delta : float):
	if Input.get_axis("left", "right"):
		transitioned.emit(self, "walk")
	elif Input.is_action_pressed("crouch") and player.is_on_floor():
		transitioned.emit(self, "crouch")
	elif Input.is_action_just_pressed("jump"):
		transitioned.emit(self, "jump")
	elif Input.is_action_just_pressed("shoot"):
		transitioned.emit(self, "shoot")
