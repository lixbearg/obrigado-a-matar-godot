extends Control

@onready var money = %Money
@onready var ammo = %Ammo


func _ready():
	GameManager.money_changed.connect(_on_money_changed)
	GameManager.ammo_changed.connect(_on_ammo_changed)
	update_money_counter()


func update_ammo_counter() -> void:
	ammo.text = "x%s" % str(GameManager.current_ammo)


func update_money_counter() -> void:
	money.text = get_currency(GameManager.current_money)


func _on_money_changed():
	update_money_counter()


func _on_ammo_changed():
	update_ammo_counter()


static func get_currency(number : float) -> String:
	var text = "%.2f" % number
	text = text.replace(".", ",")
	for idx in range(text.find(",") - 3, 0, -3):
		text = text.insert(idx, ".")
	return("R$ %s" % text)
