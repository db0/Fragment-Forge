class_name ShaderWarsCounters
extends HBoxContainer

var counters := {}
var _labels := {}

func _ready() -> void:
	for c in ["time","skill","cred"]:
		counters[c] = 0
	_labels["time"] = $"PC/VBC/HBC/TimeAvailable"
	_labels["skill"] = $"PC/VBC/HBC2/Skill"
	_labels["cred"] = $"PC/VBC/HBC3/Cred"


func mod_counter(counter_name: String, 
		value: int,
		set_to_mod := false,
		check := false) -> int:
	var retcode = CFConst.ReturnCode.CHANGED
	if counters.get(counter_name, null) == null:
		retcode = CFConst.ReturnCode.FAILED
	else:
		if set_to_mod and counters[counter_name] == value:
			retcode = CFConst.ReturnCode.OK
		elif set_to_mod and counters[counter_name] < 0:
			retcode = CFConst.ReturnCode.FAILED
		else:
			if counters[counter_name] + value < 0:
				retcode = CFConst.ReturnCode.FAILED
				value = -counters[counter_name]
			if not check:
				if set_to_mod:
					counters[counter_name] = value
				else:
					counters[counter_name] += value
			_labels[counter_name].text = str(counters[counter_name])
	return(retcode)
