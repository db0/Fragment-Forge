extends Hand


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if hand_size != cfc.NMAP.board.counters.get_counter("motivation"):
		hand_size = cfc.NMAP.board.counters.get_counter("motivation")


# Takes the top card from the specified [CardContainer]
# and adds it to this node
# Returns a card object drawn
func draw_card(pile : Pile = cfc.NMAP.deck) -> Card:
	var card: Card = pile.get_top_card()
	# A basic function to pull a card from out deck into our hand.
	if card \
			and cfc.NMAP.board.counters.get_counter("time") > 0 \
			and get_card_count() < hand_size:
		cfc.NMAP.board.counters.mod_counter("time", -1)
		card.move_to(self)
	return card

func fill_starting_hand() -> void:
	while get_card_count() < 5:
		var card: Card = cfc.NMAP.deck.get_top_card()
		card.move_to(self)
