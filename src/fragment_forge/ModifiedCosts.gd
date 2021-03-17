# Using PopupPanel avoids the scaling of the parent
extends PopupPanel
#extends PanelContainer

onready var modified_time_cost = $"HBC/TimeCosts/ModifiedCost"
onready var printed_time_cost = $"HBC/TimeCosts/HBC/VBC/PrintedCost"
onready var time_modifier := {
	"skill": $HBC/TimeCosts/HBC/VBC/SkillModifier,
	"card": $HBC/TimeCosts/HBC/VBC/CardsModifier
}
onready var time_alterant_container := {
	"skill": $HBC/TimeCosts/HBC/VBC/SkillAlterants/VBC,
	"card": $HBC/TimeCosts/HBC/VBC/TimeAlterants/VBC
}

onready var modified_kudos_cost = $"HBC/KudosCosts/ModifiedCost"
onready var printed_kudos_cost = $"HBC/KudosCosts/HBC/VBC/PrintedCost"
onready var kudos_modifier = $HBC/KudosCosts/HBC/VBC/CardsModifier
onready var kudos_alterant_container = $HBC/KudosCosts/HBC/VBC/TimeAlterants/VBC

var time_alterants_cards_displayed := {
	"skill": {},
	"card": {}
}
var kudos_alterants_cards_displayed := {}

func _ready() -> void:
	pass

func update_time_labels(
			modified: int,
			printed: int,
			skill_mod := 0,
			card_mod := 0,
			alterants := {"skill": {}, "card": {}}) -> void:
	if modified >= 1000:
		if skill_mod >= 1000:
			modified_time_cost.text = "Impossible due to low skill"
		else:
			modified_time_cost.text = "Impossible due to card effects"
	else:
		modified_time_cost.text = "Modified Time Cost: " + str(modified)
	printed_time_cost.text = "Printed Cost: " + str(printed)
	if skill_mod >= 1000:
		time_modifier["skill"].text = "Skill Modifier: " + (char(8734))
	else:
		time_modifier["skill"].text = "Skill Modifier: " + strint(skill_mod)
	if card_mod >= 1000:
		time_modifier["card"].text = "Card Modifier: " + (char(8734))
	else:
		time_modifier["card"].text = "Card Modifier: " + strint(card_mod)
	if modified >= 1000:
		modified_time_cost.set("custom_colors/font_color",
				# We multiply with 0.8 to remove the glow
				CFConst.CostsState.IMPOSSIBLE * 0.8)
	elif modified > printed:
		modified_time_cost.set("custom_colors/font_color",
				# We multiply with 0.8 to remove the glow
				CFConst.CostsState.INCREASED * 0.8)
	elif modified < printed:
		modified_time_cost.set("custom_colors/font_color",
				CFConst.CostsState.DECREASED * 0.8)
	else:
		modified_time_cost.set("custom_colors/font_color",
				CFConst.CostsState.OK)
	if skill_mod >= 1000:
		time_modifier["skill"].set("custom_colors/font_color",
				CFConst.CostsState.IMPOSSIBLE * 0.8)
	else:
		time_modifier["skill"].set("custom_colors/font_color",
				get_colour_for_modifier(skill_mod))
	if card_mod >= 1000:
		time_modifier["card"].set("custom_colors/font_color",
				CFConst.CostsState.IMPOSSIBLE * 0.8)
	else:
		time_modifier["card"].set("custom_colors/font_color",
				get_colour_for_modifier(card_mod))
	for type in alterants.keys():
		for card in alterants[type]:
			if not card in time_alterants_cards_displayed[type].keys() \
					and alterants[type][card] != 0:
				var alterant_label = time_modifier[type].duplicate()
				time_alterants_cards_displayed[type][card] = alterant_label
				alterant_label.text = card.canonical_name
				alterant_label.set("custom_colors/font_color",
						get_colour_for_alterant(type, alterants[type][card]))
				time_alterant_container[type].add_child(alterant_label)
		for card in time_alterants_cards_displayed[type]:
			if not card in alterants[type]:
				time_alterants_cards_displayed[type][card].queue_free()
				time_alterants_cards_displayed[type].erase(card)

func update_kudos_labels(
			modified: int,
			printed: int,
			card_mod := 0,
			alterants := {}) -> void:
	modified_kudos_cost.text = "Modified Kudos Cost: " + str(modified)
	printed_kudos_cost.text = "Printed Cost: " + str(printed)
	kudos_modifier.text = "Card Modifier: " + strint(card_mod)
	if modified > printed:
		modified_kudos_cost.set("custom_colors/font_color",
				# We multiply with 0.8 to remove the glow
				CFConst.CostsState.INCREASED * 0.8)
	elif modified < printed:
		modified_kudos_cost.set("custom_colors/font_color",
				CFConst.CostsState.DECREASED * 0.8)
	else:
		modified_kudos_cost.set("custom_colors/font_color",
				CFConst.CostsState.OK)
	kudos_modifier.set("custom_colors/font_color",
			get_colour_for_modifier(card_mod))
	for card in alterants:
		if not card in kudos_alterants_cards_displayed.keys() \
				and alterants[card] != 0:
			var alterant_label = kudos_modifier.duplicate()
			kudos_alterants_cards_displayed[card] = alterant_label
			alterant_label.text = card.canonical_name
			alterant_label.set("custom_colors/font_color",
					get_colour_for_alterant("card", alterants[card]))
			kudos_alterant_container.add_child(alterant_label)
	for card in kudos_alterants_cards_displayed:
		if not card in alterants:
			kudos_alterants_cards_displayed[card].queue_free()
			# warning-ignore:return_value_discarded
			kudos_alterants_cards_displayed.erase(card)
	if printed > 0 or modified > 0:
		$HBC/Separator.visible = true
		$HBC/KudosCosts.visible = true
	else:
		$HBC/Separator.visible = false
		$HBC/KudosCosts.visible = false


func get_colour_for_modifier(modifier: int, reversed := false) -> Color:
	if reversed:
		modifier *= -1
	var ret_colour : Color
	if modifier < 0:
		ret_colour = CFConst.CostsState.DECREASED * 0.8
	elif modifier > 0:
		ret_colour = CFConst.CostsState.INCREASED * 0.8
	else:
		ret_colour = CFConst.CostsState.OK
	return(ret_colour)

func get_colour_for_alterant(type: String, modifier: int) -> Color:
	var reversed := false
	if type == "skill":
		reversed = true
	return(get_colour_for_modifier(modifier, reversed))

func strint(number: int) -> String:
	var strint : String
	if number > 0:
		strint = "+" + str(number)
	else:
		strint = str(number)
	return(strint)

func reset_sizes() -> void:
	$HBC/TimeCosts/HBC/VBC.rect_size = Vector2(0,0)
	$HBC/TimeCosts/HBC.rect_size = Vector2(0,0)
	$HBC/TimeCosts.rect_size = Vector2(0,0)
	rect_size = Vector2(0,0)
