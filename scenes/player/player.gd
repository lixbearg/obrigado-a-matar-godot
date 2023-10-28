extends CharacterBody2D

signal ammo_changed(value)

@onready var BULLET = preload("res://scenes/player/bullet.tscn")
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var shadow = $Shadow
@onready var reload_timer = $ReloadTimer

const SPEED : float = 100.0
const JUMP_VELOCITY : float = -350.0
const WEAPON_POS_STANDING : Vector2i = Vector2i(15, 39)
const WEAPON_POS_CROUCHING : Vector2i = Vector2i(27, 25)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var floor_initial_position : int
var player_facing_direction : int = 1
var is_crouching : bool = false
var ammo : int = 6
var money : float = 0.0


func _ready():
	floor_initial_position = shadow.global_position.y
	reload_timer.timeout.connect(_on_weapon_reloaded)


func _physics_process(delta):
	var input_axis = Input.get_axis("left", "right")

	handle_movement(delta)
	handle_jump(delta)
	handle_crounching()
	handle_shooting()
	update_animations(input_axis)


func handle_movement(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func handle_jump(delta):
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY


func handle_crounching():
	is_crouching = Input.is_action_pressed("crouch") and is_on_floor()


func handle_shooting():
	if !reload_timer.is_stopped(): return
	if Input.is_action_just_pressed("shoot"):
		var bullet = BULLET.instantiate()
		bullet.set_direction(player_facing_direction)
		get_parent().add_child(bullet)
		if is_crouching:
			bullet.global_position.y = position.y - WEAPON_POS_CROUCHING.y
			bullet.global_position.x = position.x + (player_facing_direction * WEAPON_POS_CROUCHING.x)
		else:
			bullet.global_position.y = position.y - WEAPON_POS_STANDING.y
			bullet.global_position.x = position.x + (player_facing_direction * WEAPON_POS_STANDING.x)

		ammo -= 1
		if ammo == 0:
			reload_weapon()
		ammo_changed.emit(ammo)


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


func update_money(value):
	money += value


func reload_weapon():
	reload_timer.start()


func _on_weapon_reloaded():
	ammo = 6
	ammo_changed.emit(ammo)
	reload_timer.stop()
