class_name Player
extends Actor

@onready var shadow : Sprite2D = $Shadow
@onready var weapon : Weapon = $Weapon
@onready var skin : ActorSkin = $Skin
@onready var hurt_sfx = $HurtSFX


var default_skin = preload("res://scenes/player/skins/joao_amorim.tres")
var floor_initial_position : int
var player_facing_direction : int = 1
var is_walking : bool = false
var is_crouching : bool = false


func _ready():
	speed = 100.0
	floor_initial_position = shadow.global_position.y
	skin.set_sprite_frames(default_skin)
	GameManager.player = self


func _physics_process(delta):
	var input_axis = Input.get_axis("left", "right")
	handle_movement(delta)
	handle_jump()
	handle_attacking()
	apply_friction(delta)
	update_animations(input_axis)
	super(delta)


func handle_movement(delta):
	direction = Input.get_axis("left", "right")
	if direction:
		is_walking = true
		walk()
	else:
		is_walking = false
	is_crouching = Input.is_action_pressed("crouch") and is_on_floor() and !direction


func handle_jump():
	if Input.is_action_just_pressed("jump"):
		jump()


func handle_attacking():
	if Input.is_action_just_pressed("shoot"):
		weapon.shoot(player_facing_direction, is_crouching)
	if Input.is_action_just_pressed("reload"):
		weapon.reload()


func apply_friction(delta):
	if direction == 0:
		velocity.x = move_toward(velocity.x, 0, speed)


func update_animations(input_axis):
	if input_axis != 0 and !is_on_wall():
		skin.flip_h = input_axis < 0
		player_facing_direction = input_axis
		skin.play("walk")
	elif is_crouching:
		skin.play("crouch")
	else:
		skin.play("idle")

	shadow.global_position.x = global_position.x
	shadow.global_position.y = floor_initial_position

	if not is_on_floor():
		skin.play("jump")

func die():
	print("died!")
