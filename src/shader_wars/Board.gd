# Code for a sample playspace, you're expected to provide your own ;)
extends Board

var allCards := [] # A pseudo-deck array to hold the card objects we want to pull

onready var start_button := $VBC/Details/Start
onready var debug_button := $VBC/Details/Debug

onready var competitions : Competitions = $VBC/Details/VBC/Competition
onready var game_goal := $VBC/Details/VBC2/GameGoal

var tournament := 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	counters = $VBC/Details/Counters
	cfc.map_node(self)
	# We use the below while to wait until all the nodes we need have been mapped
	# "hand" should be one of them.
	# We're assigning our positions programmatically,
	# instead of defining them on the scene.
	# This way any they will work with any size of viewport in a game.
	# Discard pile goes bottom right
	$Debug.pressed = cfc._debug
# warning-ignore:return_value_discarded
	start_button.connect("pressed", self, "_on_Start_pressed")
# warning-ignore:return_value_discarded
	debug_button.connect("pressed", self, "_on_Debug_pressed")
	# Fill up the deck for demo purposes
	if not cfc.ut:
		cfc.game_rng_seed = CFUtils.generate_random_seed()
	if not get_tree().get_root().has_node('Gut'):
		load_deck()


func _on_Start_pressed() -> void:
# warning-ignore:return_value_discarded
	if start_button.text != "Next Competition":
		cfc.NMAP.hand.hand_size = 8
		cfc.NMAP.hand.fill_starting_hand()
		start_button.text = "Next Competition"
		competitions.next_competition()
	else:
	# warning-ignore:return_value_discarded
		counters.mod_counter("skill",1)
		counters.mod_counter("cred",competitions.get_cred_rewards())
		for c in get_all_cards():
			if c.properties.Type == CardConfig.CardTypes.SHADER:
				c.move_to(cfc.NMAP.discard)
				yield(get_tree().create_timer(0.1), "timeout")
		competitions.next_competition()

func start_turn() -> void:
	pass

func _on_Debug_pressed() -> void:
	game_goal.cred_goal = 30
# warning-ignore:return_value_discarded
	counters.mod_counter("time",30)
# warning-ignore:return_value_discarded
	counters.mod_counter("cred",10)
# warning-ignore:return_value_discarded
	counters.mod_counter("skill",10)
# warning-ignore:return_value_discarded
	counters.mod_counter("kudos",10)
# warning-ignore:return_value_discarded
	counters.mod_counter("motivation",8)


# Reshuffles all Card objects created back into the deck
func _on_ReshuffleAllDeck_pressed() -> void:
	reshuffle_all_in_pile(cfc.NMAP.deck)


func _on_ReshuffleAllDiscard_pressed() -> void:
	reshuffle_all_in_pile(cfc.NMAP.discard)

func reshuffle_all_in_pile(pile = cfc.NMAP.deck):
	for c in get_tree().get_nodes_in_group("cards"):
		if c.get_parent() != pile:
			c.move_to(pile)
			yield(get_tree().create_timer(0.1), "timeout")
	# Last card in, is the top card of the pile
	var last_card : Card = pile.get_top_card()
	if last_card._tween.is_active():
		yield(last_card._tween, "tween_all_completed")
	yield(get_tree().create_timer(0.2), "timeout")
	pile.shuffle_cards()


func _on_Debug_toggled(button_pressed: bool) -> void:
	cfc._debug = button_pressed

# Loads a sample set of cards to use for testing
func load_test_cards(extras := 11) -> void:
	var test_cards := []
	for ckey in cfc.card_definitions.keys():
		test_cards.append(ckey)
	var test_card_array := []
	for _i in range(extras):
		if not test_cards.empty():
			var random_card_name = \
					test_cards[CFUtils.randi() % len(test_cards)]
			test_card_array.append(cfc.instance_card(random_card_name))
	# 11 is the cards GUT expects. It's the testing standard
	if extras == 11:
	# I ensure there's of each test card, for use in GUT
		for card_name in test_cards:
			test_card_array.append(cfc.instance_card(card_name))
	for card in test_card_array:
		$Deck.add_child(card)
		# warning-ignore:return_value_discarded
		#card.set_is_faceup(false,true)
		card._determine_idle_state()
		allCards.append(card) # Just keeping track of all the instanced card objects for demo purposes

# Loads a sample set of cards to use for testing
func load_deck() -> void:
	var deck = load("res://src/shader_wars/decks/first_deck.gd")
	var cards_array := []
	for card_name in deck.CONTENTS:
		for _iter in range(deck.CONTENTS[card_name]):
			cards_array.append(cfc.instance_card(card_name))
	for card in cards_array:
		cfc.NMAP.deck.add_child(card)
		# warning-ignore:return_value_discarded
		#card.set_is_faceup(false,true)
		card._determine_idle_state()
	cfc.NMAP.deck.shuffle_cards()


func reset_game() -> void:
	for c in get_tree().get_nodes_in_group("cards"):
		c.queue_free()
		
