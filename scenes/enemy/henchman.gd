class_name Henchman
extends Enemy

@onready var sprite_2d = $Sprite2D
@onready var jump_timer : Timer = $JumpTimer
@onready var shoot_timer : Timer = $ShootTimer
@onready var bullet_scene = preload("res://scenes/enemy/enemy_bullet.tscn")

const WEAPON_POS_STANDING : Vector2i = Vector2i(15, 39)
const WEAPON_POS_CROUCHING : Vector2i = Vector2i(27, 25)

func _ready():
	speed = 15
	jump_timer.timeout.connect(_on_jump_timer_timeout)
	shoot_timer.timeout.connect(_on_shoot_timer_timeout)
	jump_timer.start()
	shoot_timer.start()

func _physics_process(delta):
	set_direction()
	walk()
	super(delta)


func set_direction():
	if GameManager.get_player_position().x > position.x:
		direction = 1
	else:
		direction = -1
	sprite_2d.flip_h = GameManager.get_player_position().x > (position.x + 5)


func _on_jump_timer_timeout():
	jump()
	jump_timer.start()


func _on_shoot_timer_timeout():
	var bullet = bullet_scene.instantiate()
	bullet.set_direction(direction)
	GameManager.add_object(bullet)
	bullet.global_position.y = global_position.y - WEAPON_POS_STANDING.y
	bullet.global_position.x = global_position.x + (direction * WEAPON_POS_STANDING.x)
	shoot_timer.start()

