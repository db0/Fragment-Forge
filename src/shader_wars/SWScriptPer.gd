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
