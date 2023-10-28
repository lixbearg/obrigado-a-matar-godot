extends Node2D

@onready var hud = $CanvasLayer/HUD

var enemies : Array[Node]


func _ready():
	make_connections()


func _process(delta):
	$Camera2D.position.x = $Player.position.x - 80


func make_connections():
	$Player.ammo_changed.connect(_on_ammo_changed)
	enemies = get_tree().get_nodes_in_group("enemy")
	for enemy in enemies:
		enemy.died.connect(_on_enemy_died)


# Callables
func _on_ammo_changed(value):
	hud.update_ammo_counter($Player.ammo)


func _on_enemy_died(value):
	$Player.update_money(value)
	hud.update_money_counter($Player.money)
