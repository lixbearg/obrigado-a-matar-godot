class_name HenchmanIdle
extends State

@export var enemy : Henchman
@export var move_speed : int = 20

var player : Player
var move_direction : int
var wander_time : float


func randomize_wander():
	move_direction = randi_range(-1, 1)
	wander_time = randi_range(1, 3)


func enter():
	player = get_tree().get_first_node_in_group("player")
	randomize_wander()


func state_update(delta : float):
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander()


func physics_update(delta : float):
	if enemy:
		enemy.velocity.x = move_direction * move_speed

	var direction = player.global_position - enemy.global_position
	if direction.length() < 100:
		transitioned.emit(self, "engage")
