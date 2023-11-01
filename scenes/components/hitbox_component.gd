class_name HitboxComponent
extends Area2D


@export var health_component : HealthComponent


func damage(attack : Attack):
	if health_component:
		health_component.damage(attack)
		knockback(attack)


func knockback(attack : Attack):
	var direction = (global_position.x - attack.attack_position.x)
	get_parent().velocity.x = direction * attack.knockback_force
#	get_parent().velocity.y = attack.knockback_force * -50
