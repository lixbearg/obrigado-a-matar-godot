class_name PlayerBaseState
extends State

@export var move_speed : int = 400

@onready var skin = $"../../Skin"
@onready var player = $"../.."


func _physics_process(_delta):
	if Input.get_axis("left", "right") != 0:
		skin.flip_h = Input.get_axis("left", "right") < 0
		player.facing_direction = Input.get_axis("left", "right")
