extends Control

signal suit_selected(suit: Card.Suit)

@onready var buttons_container: HBoxContainer = $PanelContainer/VBoxContainer/ButtonsContainer

func setup(suits: Array) -> void:
	clear_buttons()
	
	for suit in suits:
		var button := Button.new()
		button.text = Card.get_suit_name(suit)
		button.pressed.connect(func(): suit_selected.emit(suit))
		buttons_container.add_child(button)


func clear_buttons() -> void:
	for child in buttons_container.get_children():
		child.queue_free()
