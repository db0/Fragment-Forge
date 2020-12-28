extends "res://tests/UTcommon.gd"

var cards := []
var card: Card
var target: Card

func before_all():
	cfc.fancy_movement = false

func after_all():
	cfc.fancy_movement = true

func before_each():
	var confirm_return = setup_board()
	if confirm_return is GDScriptFunctionState: # Still working.
		confirm_return = yield(confirm_return, "completed")
	cards = draw_test_cards(5)
	yield(yield_for(0.1), YIELD)
	card = cards[0]
	target = cards[2]



func test_per_counter():
	board.counters.mod_counter("time", 3)
	card.scripts = {"manual": {
		"hand": [
			{"name": "move_card_to_container",
			"subject": "index",
			"subject_count": "per_counter",
			"src_container": deck,
			"dest_container": hand,
			"subject_index": "top",
			"per_counter": {
				"counter": "time"}
			},
		]}
	}
	card.execute_scripts()
	yield(yield_for(0.5), YIELD)
	assert_eq(hand.get_card_count(), 8,
		"Draw 1 card per cost of this card.")


