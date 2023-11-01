class_name HealthComponent
extends Node2D


@export var MAX_HEALTH : int = 3
var health : int


func _ready():
	health = MAX_HEALTH


func damage(attack : Attack):
	health -= attack.attack_damage

	if health <= 0:
		get_parent().die()
