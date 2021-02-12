class_name FragmentForgeScriptingEngine
extends ScriptingEngine

# Just calls the parent class.
func _init(card_owner: Card,
		scripts_queue: Array,
		check_costs := false,
		_trigger_card: Card = null,
		_trigger_details = {}).(card_owner,
		scripts_queue,
		check_costs,
		_trigger_card,
		_trigger_details) -> void:
	pass
