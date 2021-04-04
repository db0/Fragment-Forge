extends Node

enum Difficulties {
	START = -5
	EXTRA_COMPETITION
	REDUCED_VALUE_REQ
	REDUCED_CRED_REQ
	NO_MOTIVATION_LOSS
	NORMAL
	FIRST_CRED_REQ_INCREASE
	SKILL_DISCOUNT_ROUND_DOWN
	FIRST_VALUE_REQ_INCREASE
	RANDOM_EVENTS
	SECOND_CRED_REQ_INCREASE
	STARTING_MOTIVATION_DECREASE
	SECOND_VALUE_REQ_INCREASE
	MORE_MOTIVATION_LOSS
	NO_MOTIVATION_GAIN
	INCREASED_SKILL_PENALTY
	THIRD_CRED_REQ_INCREASE
	THIRD_VALUE_REQ_INCREASE
	END
}
const DIFFICULTIES_DESCRIPTIONS = {
	Difficulties.EXTRA_COMPETITION: 
			"1 Extra Competition available",
	Difficulties.REDUCED_VALUE_REQ: 
			"-1 Tournament value requirements",
	Difficulties.REDUCED_CRED_REQ: 
			"-1 cred needed to win",
	Difficulties.NO_MOTIVATION_LOSS: 
			"No Motivation loss for not placing in a competition",
	Difficulties.NORMAL: "Normal Game",
	Difficulties.FIRST_CRED_REQ_INCREASE: 
			"+1 cred needed to win",
	Difficulties.SKILL_DISCOUNT_ROUND_DOWN: 
			"Maximum discount of Shaders due to skill is rounded down",
	Difficulties.FIRST_VALUE_REQ_INCREASE: 
			"+1 Tournament value requirements",
	Difficulties.RANDOM_EVENTS: 
			"Random events (not implemented yet)",
	Difficulties.SECOND_CRED_REQ_INCREASE: 
			"+1 cred needed to win",
	Difficulties.STARTING_MOTIVATION_DECREASE: 
			"-1 Starting Motivation",
	Difficulties.SECOND_VALUE_REQ_INCREASE: 
			"+1 Tournament value requirements",
	Difficulties.MORE_MOTIVATION_LOSS: 
			"-1 extra motivation when not placing in a tournament",
	Difficulties.NO_MOTIVATION_GAIN: 
			"No motivation gain when winning a tournament",
	Difficulties.INCREASED_SKILL_PENALTY: 
			"Penalty for having lower skill than the shader increased",
	Difficulties.THIRD_CRED_REQ_INCREASE: 
			"+1 cred needed to win",
	Difficulties.THIRD_VALUE_REQ_INCREASE: 
			"+1 Tournament value requirements",
}
const GAME_STATS := {
	"manual_draw_time": 0,
	"competitions": {
		1: -1,
		2: -1,
		3: -1,
	},
	"motivation": 0,	
}

var current_deck: Dictionary
var current_persona: Persona
var difficulty: int setget set_difficulty
var game_stats := GAME_STATS.duplicate()
var is_tutorial: bool


func _ready() -> void:
	difficulty = cfc.game_settings.get('difficulty', 0)


func set_difficulty(value) -> void:
	difficulty = value
	cfc.set_setting('difficulty', value)

func reset_game() -> void:
	game_stats = GAME_STATS.duplicate()
