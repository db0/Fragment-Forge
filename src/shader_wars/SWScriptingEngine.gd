class_name ShaderWarsScriptingEngine
extends ScriptingEngine

# Just calls the parent class.
func _init(card_owner: Card,
		scripts_queue: Array,
		check_costs := false).(card_owner,
		scripts_queue,
		check_costs) -> void:
	pass

# Task for modifying a a counter
func mod_counter(script: ScriptTask) -> int:
	var counter_name: String = script.get_property(SWSP.KEY_COUNTER)
	var modification: int
	if str(script.get_property(SP.KEY_MODIFICATION)) == SP.VALUE_RETRIEVE_INTEGER:
		modification = stored_integer
	else:
		modification = script.get_property(SP.KEY_MODIFICATION)
	var set_to_mod: bool = script.get_property(SP.KEY_SET_TO_MOD)
	var retcode: int = cfc.NMAP.board.counters.mod_counter(
			counter_name,
			modification,
			set_to_mod,
			costs_dry_run)
	return(retcode)
