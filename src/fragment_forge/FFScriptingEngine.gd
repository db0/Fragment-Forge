class_name FragmentForgeScriptingEngine
extends ScriptingEngine

# Just calls the parent class.
func _init(state_scripts: Array,
		owner,
		_trigger_card: Card,
		_trigger_details: Dictionary).(state_scripts,
		owner,
		_trigger_card,
		_trigger_details) -> void:
	pass


func mod_competition(script: ScriptTask) -> int:
	var place: int = script.get_property(SP.KEY_PLACE)
	var modification: int
	var alteration = 0
	# We inject the tags from the script into the tags sent by the signal
	var tags: Array = ["Scripted"] + script.get_property(SP.KEY_TAGS)
	if str(script.get_property(SP.KEY_MODIFICATION)) == SP.VALUE_RETRIEVE_INTEGER:
		# If the modification is requested, is only applies to stored integers
		# so we flip the stored_integer's value.
		modification = stored_integer
		if script.get_property(SP.KEY_IS_INVERTED):
			modification *= -1
	elif SP.VALUE_PER in str(script.get_property(SP.KEY_MODIFICATION)):
		var per_msg = perMessage.new(
				script.get_property(SP.KEY_MODIFICATION),
				script.owner,
				script.get_property(script.get_property(SP.KEY_MODIFICATION)),
				null,
				script.subjects)
		modification = per_msg.found_things
	else:
		modification = script.get_property(SP.KEY_MODIFICATION)
	var set_to_mod: bool = script.get_property(SP.KEY_SET_TO_MOD)
	if not set_to_mod:
		alteration = _check_for_alterants(script, modification)
		if alteration is GDScriptFunctionState:
			alteration = yield(alteration, "completed")
	if script.get_property(SP.KEY_STORE_INTEGER):
		var current_count = cfc.NMAP.board.competitions.get_placement_requirements(
				place, script.owner)
		if set_to_mod:
			stored_integer = modification + alteration - current_count
		elif current_count + modification + alteration < 0:
			stored_integer = -current_count
		else:
			stored_integer = modification + alteration
	var retcode: int = cfc.NMAP.board.competitions.mod_place_requirements(
			place,
			modification + alteration,
			set_to_mod,
			costs_dry_run(),
			script.owner,
			tags)
	return(retcode)
