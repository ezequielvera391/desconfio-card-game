class_name Deck
extends CardCollection


func shuffle() -> void:
	cards.shuffle()


func draw() -> Card:
	if cards.is_empty():
		return null

	return cards.pop_back()
