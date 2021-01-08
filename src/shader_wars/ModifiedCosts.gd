# Using PopupPanel avoids the scaling of the parent
extends PopupPanel
#extends PanelContainer

onready var modified_cost = $"VBC/ModifiedCost"
onready var printed_cost = $"VBC/HBC/VBC/PrintedCost"
onready var skill_modifier = $"VBC/HBC/VBC/SkillModifier"
onready var card_modifier = $"VBC/HBC/VBC/CardsModifier"

func _ready() -> void:
	pass

func update_labels(modified: int, printed: int, skill_mod := 0, card_mod := 0) -> void:
	if modified == 1000:
		modified_cost.text = "Impossible due to low skill"
	else:
		modified_cost.text = "Modified Time Cost: " + str(modified)
	printed_cost.text = "Printed Cost: " + str(printed)
	if modified == 1000:
		skill_modifier.text = "Skill Modifier: " + (char(8734))
	else:
		skill_modifier.text = "Skill Modifier: " + strint(skill_mod)
	card_modifier.text = "Card Modifier: " + strint(card_mod)
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
		skill_modifier.set("custom_colors/font_color", 
				CFConst.CostsState.IMPOSSIBLE * 0.8)
	else:
		skill_modifier.set("custom_colors/font_color", 
				get_colour_for_modifier(skill_mod))		
	card_modifier.set("custom_colors/font_color", 
			get_colour_for_modifier(card_mod))


func get_colour_for_modifier(modifier: int) -> Color:
	var ret_colour : Color
	if modifier < 0:
		ret_colour = CFConst.CostsState.DECREASED * 0.8
	elif modifier > 0:
		ret_colour = CFConst.CostsState.INCREASED * 0.8
	else:
		ret_colour = CFConst.CostsState.OK
	return(ret_colour)

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
