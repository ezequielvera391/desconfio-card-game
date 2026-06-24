class_name Hand
extends CardCollection


func play_card(card: Card) -> Card:
	if not cards.has(card):
		return null

	remove_card(card)
	return card
