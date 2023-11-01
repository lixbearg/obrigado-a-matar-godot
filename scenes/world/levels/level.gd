class_name Level
extends Node2D

var next_level : Level = null


func _ready():
	GameManager.current_level = self
