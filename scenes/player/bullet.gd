extends Area2D


const SPEED : int = 10
var direction : int = 0
var attack_damage : int = 1
var knockback_force : int = 3


func set_direction(player_direction):
	direction = player_direction
	$Sprite2D.flip_h = player_direction < 0
	knockback_force = knockback_force * direction


func _physics_process(delta):
	position.x += SPEED * direction


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_entered(area):
		if area is HitboxComponent:
			var hitbox : HitboxComponent = area
			var attack = Attack.new()
			attack.attack_damage = attack_damage
			attack.knockback_force = knockback_force
			hitbox.damage(attack)
			queue_free()
