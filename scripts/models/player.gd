class_name Player
extends RefCounted

enum PlayerType {
	HUMAN,
	AI
}

var name: String
var type: PlayerType
var hand: Hand


func _init(_name: String, _type: PlayerType):
	name = _name
	type = _type
	hand = Hand.new()


func card_count() -> int:
	return hand.count()


func has_no_cards() -> bool:
	return hand.is_empty()
