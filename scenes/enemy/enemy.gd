class_name Enemy
extends Actor

var money : float = randf_range(1.0, 5.0)


func _physics_process(delta):
	super(delta)


func die():
	GameManager.update_money(money)
	queue_free()
