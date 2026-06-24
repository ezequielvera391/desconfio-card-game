class_name TablePile
extends CardCollection


func take_all_cards() -> Array[Card]:
	var taken_cards := cards.duplicate()
	cards.clear()
	return taken_cards
