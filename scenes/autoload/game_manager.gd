extends Node

signal money_changed
signal ammo_changed

var player : Player
var current_level : Level
var current_money : float = 0.0
var current_ammo : int = 6
var current_lives : int = 3


func add_object(object : Node):
	current_level.add_child(object)


func get_player_position():
	return player.position


func update_money(value : float):
	current_money += value
	money_changed.emit()


func update_ammo(value : int):
	current_ammo = value
	ammo_changed.emit()
