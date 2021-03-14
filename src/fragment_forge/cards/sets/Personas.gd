class_name PersonaDefinitions
extends Reference


const PERSONAS := {
### BEGIN Shaders ###
	"Fractal Thoughts": {
		"Ability": "Every Competition ,reduce the Time cost "\
				+ "of the third different shader you install by 3",
		"Affinity": "ART",
		"Inspiration": 25,
		"scripts_frequency": "once_per_competition",

	},
	"Enhanced": {
		"Ability": "You start the game with +1 Motivation",
		"Affinity": "ART",
		"Inspiration": 25,
		"scripts_frequency": "once_per_game",
		"scripts": {
			"game_start": {
				"persona": [
					{
						"name": "mod_counter",
						"counter_name": "motivation",
						"modification": 1,
					},
				],
			},
		},
	},
	"Imploder": {
		"Ability": "Once per competition after your motivation "\
				+ "goes below 3, gain 1 motivation",
		"Affinity": "ZIP",
		"Inspiration": 25,
		"scripts_frequency": "once_per_competition",
		"scripts": {
			"counter_modified": {
				"persona": [
					{
						"name": "mod_counter",
						"counter_name": "motivation",
						"modification": 1,
					},
				],
				"filter_count_difference": "decreased",
				"filter_count": 3,
				"comparison": 'lt',
				"filter_counter_name": "motivation",
			},
		},
	},
	"TarBall": {
		"Ability": "You start the game with 1 Cred",
		"Affinity": "ZIP",
		"Inspiration": 25,
		"scripts_frequency": "once_per_game",
		"scripts": {
			"game_start": {
				"persona": [
					{
						"name": "mod_counter",
						"counter_name": "cred",
						"modification": 1,
					},
				],
			},
		},
	},
	"Loophole": {
		"Ability": "Once per game, reduce the current competition requirements "\
				+ "for first place by 5",
		"Affinity": "WIN",
		"Inspiration": 25,
		"scripts_frequency": "once_per_game",
		"scripts": {
			"manual": {
				"persona": [
					{
						"name": "mod_competition",
						"place": Competitions.Place.FIRST,
						"modification": -5,
					},
				],
			},
		},
	},
	"Networker": {
		"Ability": "Reduce the Kudos cost by 2 of the first Tutor, "\
				+ "Collaborator or Contact you install per competition",
		"Affinity": "WIN",
		"Inspiration": 25,
		"scripts_frequency": "once_per_competition",
		"scripts": {
			"alterants": {
				"persona": [
					{
						"filter_task": "get_property",
						"filter_property_name": "Kudos",
						"alteration": -2,
						"filter_state_trigger": [
							{"filter_properties": {"Tags": "Tutor"}},
							{"filter_properties": {"Tags": "Collaborator"}},
							{"filter_properties": {"Tags": "Contact"}},
						]
					},
				],
			},
			"card_moved_to_board": {
				"persona": [
					{
						"name": "mod_counter",
						"counter_name": "time",
						"modification": 0,
					},
				],
				"filter_state_trigger": [
					{"filter_properties": {"Tags": "Tutor"}},
					{"filter_properties": {"Tags": "Collaborator"}},
					{"filter_properties": {"Tags": "Contact"}},
				]
			},
		}
	},
}

