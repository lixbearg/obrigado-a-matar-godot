extends Sprite2D

@onready var player = $".."
var floor_position : int


func _ready():
	floor_position = player.global_position.y


func _process(delta):
	global_position.x = player.global_position.x
	global_position.y = floor_position
