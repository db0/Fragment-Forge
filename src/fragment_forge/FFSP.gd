class_name FFSP
extends Reference

# Returns the default value any script definition key should have
static func get_default(property: String):
	var default
	match property:
		_:
			default = null
	return(default)
