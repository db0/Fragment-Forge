class_name Competitions
extends Control

const POSITION_MULTIPLIERS = [0, 1, 1.5, 2]
const COMPETITIONS = [
	{"name": "Basic Competition",
	"time": 20,
	"description": "No special rules",
	"placements": [10,20,30]},
	{"name": "4Kb Competition",
	"time": 20,
	"description": "You cannot have more than 8 shaders in-play",
	"placements": [8,16,32]},
	{"name": "Demojam",
	"time": 10,
	"description": "Only 10 available time",
	"placements": [7,14,28]},
]
const _PLACE_ACHIEVED_COLOR = Color(0,1,0)
const _PLACE_UNACHIEVED_COLOR = Color(1,0,0)

var current_tournament: Dictionary
var available_tournaments := []
var current_round := 0

onready var first_place := $"VBC/HBC/1stPlaceValue"
onready var first_place_text := $"VBC/HBC/1stPlaceLabel"
onready var second_place := $"VBC/HBC2/2ndPlaceValue"
onready var second_place_text := $"VBC/HBC2/2ndPlaceLabel"
onready var third_place := $"VBC/HBC3/3rdPlaceValue"
onready var third_place_text := $"VBC/HBC3/3rdPlaceLabel"
onready var description := $"VBC/HBC2/Description"
onready var demo_value := $"VBC/HBC3/DemoValue"
onready var title := $"VBC/HBC/Title"

onready var placements = {
	"first": [first_place,first_place_text],
	"second": [second_place,second_place_text],
	"third": [third_place,third_place_text],
}


func _ready() -> void:
	pass
	


func _process(_delta: float) -> void:
	var total_value := 0
	for card in cfc.NMAP.board.get_all_cards():
		if card.is_in_group("shaders"):
			total_value += card.properties.get("Value",0)
	demo_value.text = str(total_value)
	for placement in placements.values():
		if int(placement[0].text) <= total_value:
			placement[0].set("custom_colors/font_color", _PLACE_ACHIEVED_COLOR)
			placement[1].set("custom_colors/font_color", _PLACE_ACHIEVED_COLOR)
		else:
			placement[0].set("custom_colors/font_color", _PLACE_UNACHIEVED_COLOR)
			placement[1].set("custom_colors/font_color", _PLACE_UNACHIEVED_COLOR)

func next_competition() -> void:
	if available_tournaments.empty():
		available_tournaments = COMPETITIONS
		CFUtils.shuffle_array(available_tournaments)
	current_round += 1
	print_debug(current_round)
	current_tournament = available_tournaments.pop_front()
	title.text = current_tournament.name
	third_place.text = str(int(current_tournament.placements[0] * POSITION_MULTIPLIERS[current_round]))
	second_place.text = str(int(current_tournament.placements[1] * POSITION_MULTIPLIERS[current_round]))
	first_place.text = str(int(current_tournament.placements[2] * POSITION_MULTIPLIERS[current_round]))
	description.text = current_tournament.description
	cfc.NMAP.board.counters.mod_counter("time",current_tournament.time, true)
