extends Node

const DIFFICULTIES = {
	-4: "1 Extra Competition available",
	-3: "-1 Tournament value requirements",
	-2: "-1 cred needed to win",
	-1: "No Motivation loss for not placing in a competition",
	0: "Normal Game",
	1: "+1 cred needed to win",
	2: "+1 Tournament value requirements",
	3: "Random events (not implemented yet)",
	4: "+1 cred needed to win",
	5: "-1 Starting Motivation",
	6: "+1 Tournament value requirements",
	7: "-1 extra motivation when not placing in a tournament",
	8: "No motivation gain when winning a tournament",
	9: "Penalty for having lower skill than the shader increased",
	10: "+1 cred needed to win",
	11: "+1 Tournament value requirements",
}

var current_deck: Dictionary
var difficulty: int setget set_difficulty

func _ready() -> void:
	difficulty = cfc.game_settings.get('difficulty', 0)

func set_difficulty(value) -> void:
	difficulty = value
	cfc.set_setting('difficulty', value)
