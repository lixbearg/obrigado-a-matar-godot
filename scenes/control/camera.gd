extends Camera2D

@export var player : Player


func _physics_process(delta):
	position.x = player.position.x - 80
