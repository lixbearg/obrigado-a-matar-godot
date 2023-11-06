extends CanvasLayer

@onready var pause_screen = $PauseScreen

var is_paused : bool = false


func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if is_paused:
			get_tree().paused = false
			pause_screen.hide()
		else:
			get_tree().paused = true
			pause_screen.show()
		is_paused = !is_paused
