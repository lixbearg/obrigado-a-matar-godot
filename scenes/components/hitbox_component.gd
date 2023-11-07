class_name HitboxComponent
extends Area2D


@export var health_component : HealthComponent


func damage(attack : Attack):
	if health_component:
		health_component.damage(attack)
#		knockback(attack)
		get_parent().hurt_sfx.play()


func knockback(attack : Attack):
	get_parent().velocity.x += attack.knockback_force
	get_parent().velocity.y -= 100
