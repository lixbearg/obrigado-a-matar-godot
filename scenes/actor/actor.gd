class_name Actor
extends CharacterBody2D

var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")
var speed : float = 300.0
var jump_velocity : float = -400.0
var direction : int = 0
var facing_direction : int = 1


func _physics_process(delta):
	apply_gravity(delta)
	move_and_slide()


func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta


func walk():
	velocity.x = direction * speed


func jump():
	if is_on_floor():
		velocity.y = jump_velocity
