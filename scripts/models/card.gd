class_name Card
extends RefCounted

enum Suit {
	ESPADA,
	BASTO,
	ORO,
	COPA
}

var suit: Suit
var value: int

func _init(_suit: Suit, _value: int):
	suit = _suit
	value = _value

func get_display_name() -> String:
	return "%s de %s" % [str(value), Suit.keys()[suit]]
