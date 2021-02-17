# SP stands for "ScriptProperties".
#
# This dummy class exists to allow games to extend 
# the core [ScriptProperties] class provided by CGF, with their own requirements.
# 
# This is particularly useful when needing to adjust filters for the game's needs.
class_name SP
extends ScriptProperties

const FILTER_CURRENT_PLACE = "current_place"

# This call has been setup to call the original, and allow futher extension
# simply create new filter
static func filter_trigger(
		card_scripts,
		trigger_card,
		owner_card,
		trigger_details) -> bool:
	var is_valid := .filter_trigger(card_scripts,
		trigger_card,
		owner_card,
		trigger_details)
	if is_valid and card_scripts.get("filter_" + FILTER_CURRENT_PLACE) \
			and card_scripts.get("filter_" + FILTER_CURRENT_PLACE) != \
			trigger_details.get(FILTER_CURRENT_PLACE):
		is_valid = false
	return(is_valid)
