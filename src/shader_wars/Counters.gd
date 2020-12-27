class_name ShaderWarsCounters
extends PanelContainer

var counters := {}
var _labels := {}

func _ready() -> void:
	_labels["time"] = $"VBC/HBC/TimeAvailable"
	_labels["skill"] = $"VBC/HBC2/Skill"
	_labels["cred"] = $"VBC/HBC3/Cred"
	_labels["kudos"] = $"VBC/HBC5/Kudos"
	_labels["motivation"] = $"VBC/HBC4/Motivation"
	for counter_name in _labels.keys():
		counters[counter_name] = 0

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

func get_counter(counter_name: String) -> int:
	return(counters[counter_name])
