class_name ShaderWarsCounters
extends HBoxContainer

var time : int = 0 setget set_time
var skill : int = 0 setget set_skill
var cred : int = 0 setget set_cred

onready var _label_time = $"PC/VBC/HBC/TimeAvailable"
onready var _label_skill = $"PC/VBC/HBC2/Skill"
onready var _label_cred = $"PC/VBC/HBC3/Cred"

func mod_counter(counter_name: String, value: int) -> void:
	match counter_name:
		"time":
			set_time(time + value)
		"skill":
			set_skill(skill + value)
		"cred":
			set_cred(cred + value)

func set_time(value: int) -> void:
	time = value
	if time < 0: 
		time = 0
	_label_time.text = str(time)

func set_skill(value: int) -> void:
	skill = value
	if skill < 0: 
		skill = 0
	_label_skill.text = str(skill)

func set_cred(value: int) -> void:
	cred = value
	if cred < 0: 
		cred = 0
	_label_skill.text = str(cred)
