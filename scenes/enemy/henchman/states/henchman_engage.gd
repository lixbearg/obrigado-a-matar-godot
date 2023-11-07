class_name HenchmanEngage
extends State

@export var enemy : Henchman
@export var move_speed : int = 50

var player : Player
var move_direction : int


func enter():
	player = get_tree().get_first_node_in_group("player")


func physics_update(delta : float):
	var direction = player.global_position - enemy.global_position

	if direction.x < 0:
		move_direction = -1
	else:
		move_direction = 1

	if direction.length() > 50:
		enemy.velocity.x = move_direction * move_speed
	else:
		enemy.velocity = Vector2()

	if direction.length() > 150:
		transitioned.emit(self, "idle")
