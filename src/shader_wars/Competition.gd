extends Control

const _PLACE_ACHIEVED_COLOR = Color(0,1,0)
const _PLACE_UNACHIEVED_COLOR = Color(1,0,0)

onready var first_place := $"VBC/HBC/1stPlaceValue"
onready var first_place_text := $"VBC/HBC/1stPlaceLabel"
onready var second_place := $"VBC/HBC2/2ndPlaceValue"
onready var second_place_text := $"VBC/HBC2/2ndPlaceLabel"
onready var third_place := $"VBC/HBC3/3rdPlaceValue"
onready var third_place_text := $"VBC/HBC3/3rdPlaceLabel"
onready var demo_value := $"VBC/HBC2/DemoValue"

onready var placements = {
	"first": [first_place,first_place_text],
	"second": [second_place,second_place_text],
	"third": [third_place,third_place_text],
}


func _ready() -> void:
	for placement in placements.values():
		placement[0].set("custom_colors/font_color", _PLACE_UNACHIEVED_COLOR)
		placement[1].set("custom_colors/font_color", _PLACE_UNACHIEVED_COLOR)


func _process(delta: float) -> void:
	var total_value := 0
	for card in cfc.NMAP.board.get_all_cards():
		if card.is_in_group("shaders"):
			total_value += card.properties.get("Value",0)
	demo_value.text = str(total_value)
	for placement in placements.values():
		if int(placement[0].text) <= total_value:
			placement[0].set("custom_colors/font_color", _PLACE_ACHIEVED_COLOR)
			placement[1].set("custom_colors/font_color", _PLACE_ACHIEVED_COLOR)
