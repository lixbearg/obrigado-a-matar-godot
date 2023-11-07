class_name PlayerCrouch
extends PlayerBaseState


func enter():
	skin.play("crouch")


func physics_update(delta : float):
	if Input.is_action_just_pressed("jump"):
		transitioned.emit(self, "jump")
	elif !Input.is_action_pressed("crouch"):
		transitioned.emit(self, "idle")
