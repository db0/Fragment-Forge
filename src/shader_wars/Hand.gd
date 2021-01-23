extends Hand


func _ready() -> void:
	hand_size = 10

func _process(_delta: float) -> void:
	pass
#	if hand_size != cfc.NMAP.board.counters.get_counter("motivation"):
#		hand_size = cfc.NMAP.board.counters.get_counter("motivation")


# Takes the top card from the specified [CardContainer]
# and adds it to this node
# Returns a card object drawn
func draw_card(pile : Pile = cfc.NMAP.deck) -> Card:
	var card: Card = pile.get_top_card()
	# A basic function to pull a card from out deck into our hand.
	var time_cost := get_manual_draw_cost()
	if card and cfc.NMAP.board.counters.get_counter("time") >= time_cost:
		cfc.NMAP.board.counters.mod_counter("time",-time_cost)
		card.move_to(self)
	return card


func fill_starting_hand() -> void:
	while get_card_count() < 5:
		var card: Card = cfc.NMAP.deck.get_top_card()
		yield(get_tree().create_timer(0.05), "timeout")
		card.move_to(self)


func get_manual_draw_cost() -> int:
	var time_cost: int
	if get_card_count() < cfc.NMAP.board.counters.get_counter("motivation"):
		time_cost = 1
	else:
		time_cost = 2
	return(time_cost)
