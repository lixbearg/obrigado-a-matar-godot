class_name Player
extends Actor

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var shadow = $Shadow
@onready var reload_timer = $ReloadTimer
@onready var weapon = $Weapon

const SPEED : float = 100.0
const JUMP_VELOCITY : float = -350.0

var floor_initial_position : int
var player_facing_direction : int = 1
var is_walking : bool = false
var is_crouching : bool = false


func _ready():
	GameManager.player = self
	floor_initial_position = shadow.global_position.y


func _physics_process(delta):
	var input_axis = Input.get_axis("left", "right")

	handle_movement(delta)
	handle_jump()
	handle_shooting()
	update_animations(input_axis)


func handle_movement(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	var direction = Input.get_axis("left", "right")
	if direction:
		is_walking = true
		velocity.x = direction * SPEED
	else:
		is_walking = false
		velocity.x = move_toward(velocity.x, 0, SPEED)

	is_crouching = Input.is_action_pressed("crouch") and is_on_floor() and !direction

	move_and_slide()


func handle_jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY


func handle_shooting():
	if Input.is_action_just_pressed("shoot"):
		weapon.shoot(player_facing_direction, is_crouching)


func update_animations(input_axis):
	if input_axis != 0 and !is_on_wall():
		animated_sprite_2d.flip_h = input_axis < 0
		player_facing_direction = input_axis
		animated_sprite_2d.play("walk")
	elif is_crouching:
		animated_sprite_2d.play("crouch")
	else:
		animated_sprite_2d.play("idle")

	shadow.global_position.x = global_position.x
	shadow.global_position.y = floor_initial_position

	if not is_on_floor():
		animated_sprite_2d.play("jump")
