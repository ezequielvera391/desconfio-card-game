extends Control

@onready var table_view = $TableView

func _ready() -> void:
	GameManager.game_state_changed.connect(_on_game_state_changed)
	GameManager.start_game()

	# Primera carga visual
	_on_game_state_changed()


func _on_game_state_changed() -> void:
	table_view.set_current_suit(Card.get_suit_name(GameManager.current_declared_suit))
	table_view.set_pile_count(GameManager.table_pile.cards.size())
	table_view.set_turn(get_turn_label())
	table_view.set_last_play("Esperando jugada...")

func get_turn_label() -> String:
	match GameManager.current_state:
		GameManager.GameState.PLAYER_TURN:
			return "Player"
		GameManager.GameState.AI_TURN:
			return "IA"
		_:
			return "-"
