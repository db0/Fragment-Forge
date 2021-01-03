class_name Competitions
extends Control

enum Place{
	THIRD
	SECOND
	FIRST
}
# This allows me to adjust the difficulty of all tournaments in one place
# Instead of adjusting each tournament dict every time
# Each tourney dict has value requirements relevant to this number.
const STD_VALUE_PER_RANK = 12
# This is used to calculate how muc to multiple value reqs and cred rewards
# for every further round. 
# I.e. with  0.5, first round ,the multiplier will be 1
# Second round 1.5. Third round 2 etc.
const ROUND_MULTIPLIER_INCREASE := 0.5
# How many creds one gets for getting third, second, first place.
const CRED_REWARDS = [1,2,4]
const COMPETITIONS = [
	{"name": "Basic Competition",
	"time": 20,
	"description": "No special rules",
	"value_per_rank": STD_VALUE_PER_RANK},
	{"name": "4Kb Competition",
	"time": 20,
	"description": "You cannot have more than 6 shaders in-play",
	"value_per_rank": STD_VALUE_PER_RANK - 2},
	{"name": "Demojam",
	"time": 10,
	"description": "Only 10 available time",
	"value_per_rank": STD_VALUE_PER_RANK - 3},
]
# More ideas
# Flamewar: Everyone loses 1 motivation at the start. 
#	Multipler: Last player loses 1 extra. 
#	Single player: If not second place at least, lose 1 extra.
# Highly Publicized: Winner gains an extra Cred.

const _PLACE_ACHIEVED_COLOR = Color(0,1,0)
const _PLACE_UNACHIEVED_COLOR = Color(1,0,0)
const PLACE_NAMES := ["Third", "Second", "First"]

var current_tournament: Dictionary
var available_tournaments := []
var placement_requirements := [
	STD_VALUE_PER_RANK,
	STD_VALUE_PER_RANK * 2,
	STD_VALUE_PER_RANK * 3]
var current_round := 0
var current_place := -1
var round_multiplier: float

onready var first_place := $"VBC/HBC/FirstPlace"
onready var second_place := $"VBC/HBC2/SecondPlace"
onready var third_place := $"VBC/HBC3/ThirdPlace"
onready var description := $"VBC/HBC2/Description"
onready var demo_value := $"VBC/HBC3/DemoValue"
onready var title := $"VBC/HBC/Title"

onready var placements_labels = [third_place,second_place,first_place]


func _ready() -> void:
	pass
	


func _process(_delta: float) -> void:
	var total_value := 0
	for card in cfc.NMAP.board.get_all_cards():
		if card.is_in_group("shaders"):
			total_value += card.properties.get("Value",0)
	demo_value.text = "Current Demo Value: " + str(total_value)
	for p in Place.values():
		if placement_requirements[p] <= total_value:
			# In multiplayer this will be adjusted compared to other players too
			current_place = p
			placements_labels[p].set("custom_colors/font_color", _PLACE_ACHIEVED_COLOR)
		else:
			placements_labels[p].set("custom_colors/font_color", _PLACE_UNACHIEVED_COLOR)

func next_competition() -> void:
	if available_tournaments.empty():
		available_tournaments = COMPETITIONS.duplicate()
		CFUtils.shuffle_array(available_tournaments)
	# We want to set the multiplier before incrementing the round
	# so that on the first turn, the multiplier increase is 0. (0 * 0.5)
	current_place = -1
	round_multiplier = 1 + current_round * ROUND_MULTIPLIER_INCREASE
	current_round += 1
	current_tournament = available_tournaments.pop_front()
	title.text = current_tournament.name
	# These are also relevant to multiplayer, as a player cannot get first
	# place with very low value, just because the other players didn't play well
	# There's other competitors after all.
	placement_requirements = [
		current_tournament.value_per_rank * round_multiplier,
		# Second position requirements are doubled
		current_tournament.value_per_rank * 2 * round_multiplier,
		# Third position requirements are tripled
		current_tournament.value_per_rank * 3 * round_multiplier,
	]
	for p in Place.values():
		placements_labels[p].text = PLACE_NAMES[p] + " Place: "\
				+ str(int(placement_requirements[p]))\
				+ " == "\
				+ str(int(CRED_REWARDS[p] * round_multiplier))\
				+ " Cred"
	description.text = current_tournament.description
	cfc.NMAP.board.counters.mod_counter("time",current_tournament.time, true)

func get_cred_rewards() -> int:
	if current_place >= 0:
		return(int(CRED_REWARDS[current_place] * round_multiplier))
	else:
		return(0)
