class_name SWSP
extends Reference

const KEY_COUNTER := "counter"

# Returns the default value any script definition key should have
static func get_default(property: String):
	var default
	match property:
		_:
			default = null
	return(default)
