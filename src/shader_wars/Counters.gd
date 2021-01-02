extends Counters


func _ready() -> void:
	counters_container = $VBC
	value_node = "Value"
	needed_counters = {
		"time": {
			"CounterTitle": "Time Available: ",
			"Value": 20},
		"skill":{
			 "CounterTitle": "Skill: ",
			"Value": 0},
		"cred":{
			 "CounterTitle": "Cred: ",
			"Value": 0},
		"kudos":{
			 "CounterTitle": "Cred: ",
			"Value": 0},
		"motivation":{
			 "CounterTitle": "Motivation: ",
			"Value": 8},
	}
	spawn_needed_counters()
