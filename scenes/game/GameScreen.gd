extends Control

@onready var table_view = $TableView
@onready var suit_selector_view = $SuitSelectorView

func _ready() -> void:
	suit_selector_view.setup(Card.Suit.values())
	suit_selector_view.suit_selected.connect(_on_suit_selected)

	GameManager.game_state_changed.connect(_on_game_state_changed)
	GameManager.start_game()

	_on_game_state_changed()


func _on_game_state_changed() -> void:
	table_view.set_current_suit(get_current_suit_label())
	table_view.set_pile_count(GameManager.table_pile.cards.size())
	table_view.set_turn(get_turn_label())
	# TODO: reemplazar por un helper real que devuelva la información de la última jugada
	table_view.set_last_play("Esperando jugada...")

	suit_selector_view.visible = GameManager.current_state == GameManager.GameState.WAITING_ROUND_SUIT

func get_current_suit_label() -> String:
	# TODO: Mejorar lógica podría existir solo un if
	if GameManager.current_state == GameManager.GameState.WAITING_ROUND_SUIT:
		return "Sin definir"

	if GameManager.current_round_suit == null:
		return "Sin definir"

	return Card.get_suit_name(GameManager.current_round_suit)


func get_turn_label() -> String:
	match GameManager.current_state:
		GameManager.GameState.PLAYER_TURN:
			return "Player"
		GameManager.GameState.AI_TURN:
			return "IA"
		_:
			return "-"
			
func _on_suit_selected(suit: Card.Suit) -> void:
	GameManager.select_round_suit(suit)
