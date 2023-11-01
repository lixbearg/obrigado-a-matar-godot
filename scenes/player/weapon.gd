class_name Weapon
extends Node2D

@onready var bullet_scene = preload("res://scenes/player/bullet.tscn")
@onready var reload_timer = $ReloadTimer

const WEAPON_POS_STANDING : Vector2i = Vector2i(15, 39)
const WEAPON_POS_CROUCHING : Vector2i = Vector2i(27, 25)

var _max_ammo : int = 6
var _ammo : int = _max_ammo


func _ready():
	reload_timer.timeout.connect(_on_weapon_reloaded)


func shoot(player_facing_direction : int, is_crouching : bool):
	if !reload_timer.is_stopped(): return
	var player_position = GameManager.get_player_position()
	var bullet = bullet_scene.instantiate()
	bullet.set_direction(player_facing_direction)
	GameManager.add_object(bullet)
	if is_crouching:
		bullet.global_position.y = player_position.y - WEAPON_POS_CROUCHING.y
		bullet.global_position.x = player_position.x + (player_facing_direction * WEAPON_POS_CROUCHING.x)
	else:
		bullet.global_position.y = player_position.y - WEAPON_POS_STANDING.y
		bullet.global_position.x = player_position.x + (player_facing_direction * WEAPON_POS_STANDING.x)

	_set_ammo(_ammo - 1)
	if _ammo == 0:
		reload()


func reload():
	reload_timer.start()


func _on_weapon_reloaded():
	_set_ammo(_max_ammo)
	reload_timer.stop()


func _set_ammo(value):
	_ammo = value
	GameManager.update_ammo(_ammo)
