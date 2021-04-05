# Code for a sample deck, you're expected to provide your own ;)
extends Pile

signal draw_card(deck)
var tutorial_disabled := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	while cfc.NMAP.size() < 5:
		yield(cfc, "all_nodes_mapped")
	
	# warning-ignore:return_value_discarded
	$Control.connect("gui_input", self, "_on_Deck_input_event")
	# warning-ignore:return_value_discarded
	connect("draw_card", cfc.NMAP.hand, "draw_card")
	#print(get_signal_connection_list("input_event")[0]['target'].name)

func _process(_delta: float) -> void:
	if cfc.NMAP.board.mouse_pointer in get_overlapping_areas()\
			and not cfc.card_drag_ongoing:
		display_draw_time_cost()
	else:
		$TimeCostPopup.visible = false
		

func _on_Deck_input_event(event) -> void:
	if event.is_pressed()\
			and event.get_button_index() == 1\
			and not tutorial_disabled:
		emit_signal("draw_card", self)

func display_draw_time_cost():
	var draw_time_cost: int = cfc.NMAP.hand.get_manual_draw_cost()
	$TimeCostPopup/TimeCost.text = "Time Cost: " + str(draw_time_cost)
	if not $TimeCostPopup.visible:
		$TimeCostPopup.rect_global_position = Vector2(
				global_position.x
				+ $Control.rect_size.x,
				global_position.y - 50)
		$TimeCostPopup.visible = true

