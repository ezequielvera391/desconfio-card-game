class_name Turn
extends RefCounted

var active_player: Player
var played_card: Card
var has_played: bool = false


func _init(_active_player: Player):
	active_player = _active_player


func play_card(card: Card, round_suit: Card.Suit) -> LastPlay:
	if has_played:
		return null

	var card_played := active_player.hand.play_card(card)

	if played_card == null:
		return null

	played_card = card_played
	has_played = true

	return LastPlay.new(active_player, played_card, round_suit)
