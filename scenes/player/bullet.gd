extends Area2D


const SPEED : int = 10
var direction : int = 0


func set_direction(player_direction):
	direction = player_direction
	$Sprite2D.flip_h = player_direction < 0


func _physics_process(delta):
	position.x += SPEED * direction


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
