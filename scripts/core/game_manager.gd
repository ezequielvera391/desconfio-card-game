extends Node


enum GameState {
	SETUP,
	DEALING,
	PLAYER_TURN,
	AI_TURN,
	RESOLVING_CHALLENGE,
	CHECK_WIN,
	GAME_OVER
}

var current_state: GameState

var deck: Deck
var player: Player
var ai: Player
var table_pile: TablePile
var last_play: LastPlay
var current_turn: Turn
var current_declared_suit: Card.Suit
var previous_declared_suit: Card.Suit

signal game_initialized
signal game_state_changed

# El singleton GameScreen llama a gameManager.start_game() cuando termina de cargar
func _ready():
	pass
	
func start_game():
	current_state = GameState.SETUP # asignación interna, sin emitir
	setup_game()
	game_initialized.emit()
	
	# Esto es instantaneo luego tendrá una animación y probablemente tenga que esperar
	change_state(GameState.DEALING)
	deal_all_cards()
	
	change_state(GameState.PLAYER_TURN)
	
func setup_game() -> void:
	player = Player.new("Jugador", Player.PlayerType.HUMAN)
	ai = Player.new("Máquina", Player.PlayerType.AI)
	table_pile = TablePile.new()
	deck = create_spanish_deck()
	deck.shuffle()

	last_play = null
	
	# Por ahora siempre va a iniciar el Player
	current_turn = Turn.new(player)

	# TEMP: Acá lo inicio manualmente pero debe ser el primer jugador el que elija que palo jugar
	current_declared_suit = Card.Suit.ESPADA
	previous_declared_suit = current_declared_suit

	print("Partida creada.")
	
func create_spanish_deck() -> Deck:
	var new_deck := Deck.new()

	for suit in Card.Suit.values():
		for value in range(1, 13):
			new_deck.add_card(
				Card.new(suit, value)
			)

	return new_deck
	
func deal_all_cards():
	var current_player := player

	while not deck.is_empty():
		var card := deck.draw()

		current_player.hand.add_card(card)

		if current_player == player:
			current_player = ai
		else:
			current_player = player

	print("Jugador:", player.card_count())
	print("Máquina:", ai.card_count())
	print("Mazo:", deck.count())
	
func change_state(new_state: GameState):
	current_state = new_state
	print("Nuevo estado:", GameState.keys()[current_state])
	game_state_changed.emit()
	
func resolve_challenge(challenger: Player) -> void:
	var loser: Player

	print(challenger.name, " canta: ¡Desconfío!")
	print("Se revela la última jugada:")
	print("- Carta real:", last_play.cards[0].get_display_name())
	print("- Declaró:", Card.Suit.keys()[last_play.declared_suit])

	if last_play.was_truthful():
		loser = challenger
		print("Resultado: era verdad. ", challenger.name, " levanta el pozo.")
	else:
		loser = last_play.player
		print("Resultado: era mentira. ", loser.name, " levanta el pozo.")

	move_pile_to_player(loser)
	print_status()

	print(loser.name, " levanta el pozo.")
	print(player.name, " tiene ", player.card_count(), " carta/s")
	print(ai.name, " tiene ", ai.card_count(), " carta/s")
	print("Cartas en pozo: ", table_pile.count())
	
func move_pile_to_player(target_player: Player) -> void:
	var taken_cards := table_pile.take_all_cards()
	target_player.hand.add_cards(taken_cards)
	
func play_card(active_player: Player, card: Card, declared_suit: Card.Suit) -> void:
	current_turn = Turn.new(active_player)
	last_play = current_turn.play_card(card, declared_suit)

	if last_play == null:
		print("No se pudo jugar la carta.")
		return

	table_pile.add_cards(last_play.cards)

	print(active_player.name, " juega 1 carta boca abajo y declara ", Card.Suit.keys()[declared_suit], ".")
	print_status()
	
func check_win_condition() -> void:
	if player.has_no_cards():
		change_state(GameState.GAME_OVER)
		print("Ganó el Jugador.")
		return

	if ai.has_no_cards():
		change_state(GameState.GAME_OVER)
		print("Ganó la Máquina.")
		return

	
# harcode

func print_status() -> void:
	print("Jugador:", player.card_count())
	print("Máquina:", ai.card_count())
	print("Pozo:", table_pile.count())
