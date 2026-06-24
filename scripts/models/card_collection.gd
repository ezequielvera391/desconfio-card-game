class_name CardCollection
extends RefCounted

var cards: Array[Card] = []


func add_card(card: Card) -> void:
	cards.append(card)

func add_cards(new_cards: Array[Card]) -> void:
	for card in new_cards:
		add_card(card)

func remove_card(card: Card) -> void:
	cards.erase(card)


func count() -> int:
	return cards.size()


func is_empty() -> bool:
	return cards.is_empty()
