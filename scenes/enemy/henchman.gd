class_name Henchman
extends Enemy

@onready var jump_timer : Timer = $JumpTimer


func _ready():
	speed = 30
	direction = -1
	jump_timer.timeout.connect(_on_jump_timer_timeout)
	jump_timer.start()


func _physics_process(delta):
	walk()
	super(delta)


func _on_jump_timer_timeout():
	jump()
	jump_timer.start()
