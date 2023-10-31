extends Control

@onready var money = %Money
@onready var ammo = %Ammo


func update_ammo_counter(value) -> void:
	ammo.text = "x%s" % str(value)


func update_money_counter(value) -> void:
	money.text = get_currency(value)


static func get_currency(number : float) -> String:
	var text = "%.2f" % number
	text = text.replace(".", ",")
	for idx in range(text.find(",") - 3, 0, -3):
		text = text.insert(idx, ".")
	return("R$ %s" % text)
