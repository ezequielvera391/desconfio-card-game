class_name LastPlay
extends RefCounted

var player: Player
var cards: Array[Card]
var declared_suit: Card.Suit


func _init(_player: Player, _cards: Array[Card], _declared_suit: Card.Suit):
	player = _player
	cards = _cards
	declared_suit = _declared_suit


func was_truthful() -> bool:
	for card in cards:
		if card.suit != declared_suit:
			return false

	return true
