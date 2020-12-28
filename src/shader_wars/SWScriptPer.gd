# This class is responsible for looking up the amount of per count
# that has been requested in a [ScripTask](#ScriptTask)
class_name SWScriptPer
extends ScriptPer

# prepares the properties needed by the task to function.
func _init(card: Card,
		script: Dictionary,
		per_seek: String).(card,
		script,per_seek) -> void:
	pass
# Goes through the subjects specied for this per calculation
# and counts the number of "things" requested

func _count_custom() -> int:
	var ret: int
	match script_name:
		SWSP.KEY_PER_COUNTER:
			ret = _count_counter()
	return(ret)

func _count_counter() -> int:
	var ret: int
	var counter_name = get_property(SWSP.KEY_COUNTER)
	ret = cfc.NMAP.board.counters.get_counter(counter_name)
	return(ret)
	
