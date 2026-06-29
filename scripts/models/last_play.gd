class_name LastPlay
extends RefCounted

var player: Player
var card: Card
var round_suit: Card.Suit


func _init(_player: Player, _card: Card, _round_suit: Card.Suit):
	player = _player
	card = _card
	round_suit = _round_suit



func was_truthful() -> bool:
	return card.suit == round_suit
