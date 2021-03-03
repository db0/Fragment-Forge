# SP stands for "ScriptProperties".
#
# This dummy class exists to allow games to extend 
# the core [ScriptProperties] class provided by CGF, with their own requirements.
# 
# This is particularly useful when needing to adjust filters for the game's needs.
class_name SP
extends ScriptProperties

const FILTER_CURRENT_PLACE = "current_place"
const FILTER_FIRST = "first"
const FILTER_FIRST_TYPE = "first_type"

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
	if is_valid and card_scripts.get("filter_not_" + FILTER_CURRENT_PLACE) \
			and card_scripts.get("filter_not_" + FILTER_CURRENT_PLACE) == \
			trigger_details.get(FILTER_CURRENT_PLACE):
		is_valid = false
	if is_valid and card_scripts.get("filter_" + FILTER_FIRST):
			# Wants the card to have been the first played in the competition
			if card_scripts.get("filter_" + FILTER_FIRST)\
					and not cfc.NMAP.board.competitions.firsts.empty():
				is_valid = false
			# Wants the card to not have been the first played in the competition
			if not card_scripts.get("filter_" + FILTER_FIRST)\
					and cfc.NMAP.board.competitions.firsts.empty():
				is_valid = false			
	if is_valid and card_scripts.get("filter_" + FILTER_FIRST_TYPE):
			# Wants the card to have been the first of its type in the competition
			if card_scripts.get("filter_" + FILTER_FIRST)\
					and cfc.NMAP.board.competitions.firsts.\
					get(owner_card.get_property('Type')):
				is_valid = false
			# Wants the card to not have been the first of its type in the competition
			if not card_scripts.get("filter_" + FILTER_FIRST)\
					and not cfc.NMAP.board.competitions.firsts.\
					get(owner_card.get_property('Type')):
				is_valid = false
	# For the card effect of Prismatic
	if is_valid and card_scripts.get("filter_prismatic"):
		var card_names = []
		for c in cfc.NMAP.board.get_all_cards():
			if c.card_name in card_names:
				is_valid = false
				break
			else:
				card_names.append(c.card_name)
	return(is_valid)
