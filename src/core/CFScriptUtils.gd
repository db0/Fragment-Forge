# Card Gaming Framework ScriptingEngine Utilities
#
# This is a library of static functions we had to separate to avoid
# cyclic dependencies
class_name CFScriptUtils
extends Reference

# Handles modifying the intensity of tasks based on altering scripts on cards
#
# Returns a Dictionary holding two keys
# * value_alteration: The total modification found from all alterants
# * alterants_details: A dictionary where each key is the Card object
# 	of each alterant, and each value is the modification done by that
#	specific alterant.
static func get_altered_value(
		_owner_card,
		task_name: String,
		task_properties: Dictionary,
		value: int) -> Dictionary:
	var value_alteration := 0
	var alterants_details := {}
	for card in cfc.get_tree().get_nodes_in_group("cards"):
		var card_scripts = card.retrieve_card_scripts(SP.KEY_ALTERANTS)
		# We select which scripts to run from the card, based on it state
		var state_scripts = card_scripts.get(card.get_state_exec(), [])
		# To avoid unnecessary operations
		# we evoke the AlterantEngine only if we have something to execute
		var task_details = _generate_trigger_details(task_name, task_properties)
		if len(state_scripts):
			var alteng = cfc.alterant_engine.new(
					_owner_card,
					card,
					state_scripts,
					task_details)
			if not alteng.all_alterations_completed:
				yield(alteng,"alterations_completed")
			value_alteration += alteng.alteration
			# We don't want to register alterants which didn't modify the number.
			if alteng.alteration != 0:
				# Each key in the alterants_details dictionary is the
				# card object of the alterant. The value is the alteration
				# this alterant has added to the total.
				alterants_details[card] = alteng.alteration
	# As a general rule, we don't want a positive number to turn
	# negative (and the other way around) due to an alteration
	# For example: if a card says, "decrease all costs by 3",
	# we don't want a card with 1 cost, to end up giving the player 2 money.
	if value < 0 and value + value_alteration > 0:
		# warning-ignore:narrowing_conversion
		value_alteration = abs(value)
	elif value > 0 and value + value_alteration < 0:
		value_alteration = -value
	var return_dict := {
		"value_alteration": value_alteration,
		"alterants_details": alterants_details
	}
	return(return_dict)


# Parses a [ScriptTask]'s properties and extracts the details a [ScriptAlter]
# needs to check if its allowed to modify that task.
static func _generate_trigger_details(task_name, task_properties) -> Dictionary:
	var details = {
		SP.KEY_TAGS: task_properties.get(SP.KEY_TAGS),
		SP.TRIGGER_TASK_NAME: task_name}
	# This dictionary key is a ScriptEngine task name which can be modified
	# by alterants. The value is an array or task properties we need to pass
	# to the trigger filter, to check if this task is relevant to be altered.
	var details_needed_per_task := {
		"mod_tokens": [SP.KEY_TOKEN_NAME,],
		"mod_counter": [SP.KEY_COUNTER_NAME,],
		"spawn_card": [SP.KEY_SCENE_PATH,],
		"get_token": [SP.KEY_TOKEN_NAME,],
		"get_property": [SP.KEY_PROPERTY_NAME,],
		"get_counter": [SP.KEY_COUNTER_NAME,],}
	for property in details_needed_per_task.get(task_name,[]):
		details[property] = task_properties.get(property)
	return(details)
