class_name Player
extends Actor

@onready var shadow : Sprite2D = $Shadow
@onready var weapon : Weapon = $Weapon
@onready var skin : ActorSkin = $Skin
@onready var hurt_sfx = $HurtSFX

var default_skin = preload("res://scenes/player/skins/joao_amorim.tres")


func _ready():
	skin.set_sprite_frames(default_skin)
	GameManager.player = self


func _physics_process(delta):
	apply_friction(delta)
	super(delta)


func handle_attacking():
	if Input.is_action_just_pressed("reload"):
		weapon.reload()


func apply_friction(delta):
	if direction == 0:
		velocity.x = move_toward(velocity.x, 0, speed)


func die():
	print("died!")
