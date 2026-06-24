class_name Turn
extends RefCounted

var active_player: Player
var declared_suit: Card.Suit
var played_cards: Array[Card] = []
var has_played: bool = false


func _init(_active_player: Player):
	active_player = _active_player


func play_card(card: Card, _declared_suit: Card.Suit) -> LastPlay:
	if has_played:
		return null

	var played_card := active_player.hand.play_card(card)

	if played_card == null:
		return null

	declared_suit = _declared_suit
	played_cards.append(played_card)
	has_played = true

	return LastPlay.new(active_player, played_cards, declared_suit)
