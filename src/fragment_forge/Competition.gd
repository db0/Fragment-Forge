class_name Competitions
extends Control

signal competition_ended(card,trigger,details)
signal placement_modified(card,trigger,details)

enum Place{
	THIRD
	SECOND
	FIRST
}
# This allows me to adjust the difficulty of all tournaments in one place
# Instead of adjusting each tournament dict every time
# Each tourney dict has value requirements relevant to this number.
const STD_VALUE_PER_RANK = 9
# How many creds one gets for getting third, second, first place.
const CRED_REWARDS = [1,2,4]
const COMPETITIONS = [
	{"name": "Basic Competition",
	"time": 20,
	"description": "No special rules",
	"value_per_rank_adjustment": 0},
	{"name": "4Kb Competition",
	"time": 20,
	"description": "You cannot have more than 6 shaders in-play",
	"value_per_rank_adjustment": -2},
	{"name": "Demojam",
	"time": 10,
	"description": "Only 10 available time",
	"value_per_rank_adjustment": -3},
]
# More ideas
# Flamewar: Everyone loses 1 motivation at the start.
#	Multiplaer: Last player loses 1 extra.
#	Single player: If not second place at least, lose 1 extra.
# Highly Publicized: Winner gains an extra Cred.

const _PLACE_ACHIEVED_COLOR = Color(0,1,0)
const _PLACE_UNACHIEVED_COLOR = Color(1,0,0)
const PLACE_NAMES := ["3rd", "2nd", "1st"]

var current_tournament: Dictionary
var available_tournaments := []
var placement_requirements := []
var current_round := 0
var current_place := -1
var round_multiplier: float
var current_demo_value: int
# This is used to calculate how muc to multiple value reqs and cred rewards
# for every further round.
# I.e. with  0.5, first round ,the multiplier will be 1
# Second round 1.5. Third round 2 etc.
var round_multiplier_increase := 0.5
var value_per_rank
# Tracks the first of each card to have been played each competition
var firsts := {}
var temp_placement_modifiers := {}

onready var first_place := $"VBC/HBC/FirstPlace"
onready var second_place := $"VBC/HBC2/SecondPlace"
onready var third_place := $"VBC/HBC3/ThirdPlace"
onready var description := $"VBC/HBC2/Description"
onready var demo_value := $"VBC/HBC3/DemoValue"
onready var title := $"VBC/HBC/Title"

onready var placements_labels = [third_place,second_place,first_place]


func _ready() -> void:
	# warning-ignore:return_value_discarded
	self.connect("competition_ended", cfc.signal_propagator, "_on_signal_received")
	var value_per_rank_diff_ajustment := 0
	if ffc.difficulty <= ffc.Difficulties.REDUCED_VALUE_REQ:
		value_per_rank_diff_ajustment -= 1
	if ffc.difficulty >= ffc.Difficulties.FIRST_VALUE_REQ_INCREASE:
		value_per_rank_diff_ajustment += 1
	if ffc.difficulty >= ffc.Difficulties.SECOND_VALUE_REQ_INCREASE:
		value_per_rank_diff_ajustment += 1
	if ffc.difficulty >= ffc.Difficulties.THIRD_VALUE_REQ_INCREASE:
		value_per_rank_diff_ajustment += 1
	value_per_rank = STD_VALUE_PER_RANK + value_per_rank_diff_ajustment
	placement_requirements = [
		value_per_rank,
		value_per_rank * 2,
		value_per_rank * 3]

func _process(_delta: float) -> void:
	var total_value := 0
	for card in cfc.NMAP.board.get_all_cards():
		if card.is_in_group("shaders"):
			total_value += card.get_property("Value")
	var alteration = CFScriptUtils.get_altered_value(
			null, "get_demo_value", {}, total_value)
	if alteration is GDScriptFunctionState:
		alteration = yield(alteration, "completed")
	total_value += alteration.value_alteration
	# We set it as an extra step, so that there's no change we grab the value
	# while it's still calculating
	if current_demo_value != total_value:
		current_demo_value = total_value
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
	if current_round > 0:
		emit_signal("competition_ended", null, "competition_ended",
				{"competition_name": current_tournament.name,
				"demo_value": current_demo_value,
				"current_place": current_place})
		if current_place == -1:
			if ffc.difficulty > ffc.Difficulties.NO_MOTIVATION_LOSS:
				cfc.NMAP.board.counters.mod_counter("motivation",-2)
			if ffc.difficulty >= ffc.Difficulties.MORE_MOTIVATION_LOSS:
				cfc.NMAP.board.counters.mod_counter("motivation",-1)
		elif current_place == Place.FIRST:
			if ffc.difficulty < ffc.Difficulties.NO_MOTIVATION_GAIN:
				cfc.NMAP.board.counters.mod_counter("motivation",+1)
		var place_string : String
		if current_place == -1: 
			place_string = "Unqualified"
		else:
			place_string = PLACE_NAMES[current_place]
		ffc.game_stats["competitions"][current_round] = place_string
	current_place = -1
	round_multiplier = 1 + current_round * round_multiplier_increase
	current_round += 1
	current_tournament = available_tournaments.pop_front()
	title.text = current_tournament.name
	# These are also relevant to multiplayer, as a player cannot get first
	# place with very low value, just because the other players didn't play well
	# There's other competitors after all.
	placement_requirements = [
		int((value_per_rank + current_tournament.value_per_rank_adjustment) * round_multiplier),
		# Second position requirements are doubled
		int((value_per_rank + current_tournament.value_per_rank_adjustment) * 2 * round_multiplier),
		# Third position requirements are tripled
		int((value_per_rank + current_tournament.value_per_rank_adjustment) * 3 * round_multiplier),
	]
	for p in Place.values():
		placements_labels[p].text = PLACE_NAMES[p] + ': '\
				+ str(int(placement_requirements[p]))\
				+ " == "\
				+ str(int(CRED_REWARDS[p] * round_multiplier))\
				+ " Cred"
	description.text = current_tournament.description
	cfc.NMAP.board.counters.mod_counter("time",current_tournament.time, true)
	for c in cfc.NMAP.board.get_all_cards():
		c.card_rotation = 0
	firsts.clear()

func get_cred_rewards() -> int:
	if current_place >= 0:
		return(int(CRED_REWARDS[current_place] * round_multiplier))
	else:
		return(0)


func get_placement_requirements(place, requesting_object = null) -> int:
	var count = get_placement_requirements_and_alterants(place, requesting_object).count
	return(count)


func get_placement_requirements_and_alterants(
		place: int,
		requesting_object = null) -> Dictionary:
	var count = placement_requirements[place]
	# We iterate through the values, where each value is a dictionary
	# with key being the counter name, and value being the temp modifier
	var alteration = {
		"value_alteration": 0,
		"alterants_details": {}
	}
	if requesting_object:
		alteration = CFScriptUtils.get_altered_value(
			requesting_object,
			"get_placement_requirements",
			{SP.KEY_PLACE: place,},
			placement_requirements[place])
		if alteration is GDScriptFunctionState:
			alteration = yield(alteration, "completed")
	# The first element is always the total modifier from all alterants
	count += alteration.value_alteration
	var temp_modifiers = {
		"value_modification": 0,
		"modifier_details": {}
	}
	for modifiers_dict in temp_placement_modifiers.values():
		# The value_modification key hold the total modification done by
		# all temp modifiers.
		temp_modifiers.value_modification += modifiers_dict.modifier.get(place,0)
		# Each value in the modifier_details dictionary is another dictionary
		# Where the key is the card object which has added this modifier
		# And the value is the modifier this specific card added to the total
		temp_modifiers.modifier_details[modifiers_dict.requesting_card] =\
				modifiers_dict.modifier.get(place,0)
	count += temp_modifiers.value_modification
	if count < 0:
		count = 0
	var return_dict = {
		"count": count,
		"alteration": alteration,
		"temp_modifiers": temp_modifiers,
	}
	return(return_dict)

func mod_place_requirements(
		place: int,
		value: int,
		set_to_mod := false,
		check := false,
		requesting_card = null,
		tags := ["Manual"]) -> int:
	var retcode = CFConst.ReturnCode.CHANGED
	if place > 3 or place < 1:
		retcode = CFConst.ReturnCode.FAILED
	else:
		if set_to_mod and placement_requirements[place] == value:
			retcode = CFConst.ReturnCode.OK
		elif set_to_mod and placement_requirements[place] < 0:
			retcode = CFConst.ReturnCode.FAILED
		else:
			if placement_requirements[place] + value < 0:
				retcode = CFConst.ReturnCode.FAILED
				value = -placement_requirements[place]
			if not check:
				cfc.flush_cache()
				var prev_value = placement_requirements[place]
				if set_to_mod:
					placement_requirements[place] = value
				else:
					placement_requirements[place] += value
				placements_labels[place].text = PLACE_NAMES[place] + ': '\
						+ str(int(placement_requirements[place]))\
						+ " == "\
						+ str(int(CRED_REWARDS[place] * round_multiplier))\
						+ " Cred"
				emit_signal(
						"placement_modified", 
						requesting_card, 
						"placement_modified",
						{
							SP.KEY_PLACE: place,
							SP.TRIGGER_PREV_COUNT: prev_value,
							SP.TRIGGER_NEW_COUNT: placement_requirements[place],
							"tags": tags,
						}
				)
	return(retcode)
