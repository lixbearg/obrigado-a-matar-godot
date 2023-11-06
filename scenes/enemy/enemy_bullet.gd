extends Area2D

const SPEED : int = 2
var direction : int = 0
var attack_damage : int = 1


func set_direction(enemy_direction):
	direction = enemy_direction
	$Sprite2D.flip_h = enemy_direction < 0


func _physics_process(delta):
	position.x += SPEED * direction


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_entered(area):
	if area is HitboxComponent:
		var hitbox : HitboxComponent = area
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		hitbox.damage(attack)
		queue_free()
