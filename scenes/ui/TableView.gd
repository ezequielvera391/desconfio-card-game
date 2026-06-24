extends PanelContainer

@onready var current_suit_label: Label = $VBoxContainer/CurrentSuitLabel
@onready var pile_count_label: Label = $VBoxContainer/PileCountLabel
@onready var turn_label: Label = $VBoxContainer/TurnLabel
@onready var last_play_label: Label = $VBoxContainer/LastPlayLabel

func set_current_suit(value: String) -> void:
	current_suit_label.text = "Palo actual: " + value

func set_pile_count(value: int) -> void:
	pile_count_label.text = "Cartas en mesa: " + str(value)

func set_turn(value: String) -> void:
	turn_label.text = "Turno actual: " + value

func set_last_play(value: String) -> void:
	last_play_label.text = "Última jugada: " + value
