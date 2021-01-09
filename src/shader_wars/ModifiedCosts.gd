# Using PopupPanel avoids the scaling of the parent
extends PopupPanel
#extends PanelContainer

onready var modified_cost = $"VBC/ModifiedCost"
onready var printed_cost = $"VBC/HBC/VBC/PrintedCost"
onready var modifier := {
	"skill": $VBC/HBC/VBC/SkillModifier,
	"time": $VBC/HBC/VBC/CardsModifier
}
onready var alterant_container := {
	"skill": $VBC/HBC/VBC/SkillAlterants/VBC,
	"time": $VBC/HBC/VBC/TimeAlterants/VBC
}
var alterants_cards_displayed := {
	"skill": {},
	"time": {}
}

func _ready() -> void:
	pass

func update_labels(
			modified: int,
			printed: int,
			skill_mod := 0,
			card_mod := 0,
			alterants := {"skill": {}, "time": {}}) -> void:
	if modified == 1000:
		modified_cost.text = "Impossible due to low skill"
	else:
		modified_cost.text = "Modified Time Cost: " + str(modified)
	printed_cost.text = "Printed Cost: " + str(printed)
	if modified == 1000:
		modifier["skill"].text = "Skill Modifier: " + (char(8734))
	else:
		modifier["skill"].text = "Skill Modifier: " + strint(skill_mod)
	modifier["time"].text = "Card Modifier: " + strint(card_mod)
	if modified == 1000:
		modified_cost.set("custom_colors/font_color",
				# We multiply with 0.8 to remove the glow
				CFConst.CostsState.IMPOSSIBLE * 0.8)
	elif modified > printed:
		modified_cost.set("custom_colors/font_color",
				# We multiply with 0.8 to remove the glow
				CFConst.CostsState.INCREASED * 0.8)
	elif modified < printed:
		modified_cost.set("custom_colors/font_color",
				CFConst.CostsState.DECREASED * 0.8)
	else:
		modified_cost.set("custom_colors/font_color",
				CFConst.CostsState.OK)
	if modified == 1000:
		modifier["skill"].set("custom_colors/font_color",
				CFConst.CostsState.IMPOSSIBLE * 0.8)
	else:
		modifier["skill"].set("custom_colors/font_color",
				get_colour_for_modifier(skill_mod))
	modifier["time"].set("custom_colors/font_color",
			get_colour_for_modifier(card_mod))
	for type in alterants.keys():
		for card in alterants[type]:
			if not card in alterants_cards_displayed[type].keys() \
					and alterants[type][card] != 0:
				var alterant_label = modifier[type].duplicate()
				alterants_cards_displayed[type][card] = alterant_label
				alterant_label.text = card.card_name
				alterant_label.set("custom_colors/font_color",
						get_colour_for_alterant(type, alterants[type][card]))
				alterant_container[type].add_child(alterant_label)
		for card in alterants_cards_displayed[type]:
			if not card in alterants[type]:
				alterants_cards_displayed[type][card].queue_free()
				alterants_cards_displayed[type].erase(card)


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
	$VBC/HBC/VBC.rect_size = Vector2(0,0)
	$VBC/HBC.rect_size = Vector2(0,0)
	$VBC.rect_size = Vector2(0,0)
	rect_size = Vector2(0,0)
