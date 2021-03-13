class_name PersonaDefinitions
extends Reference


const PERSONAS := {
### BEGIN Shaders ###
	"Fractal Thoughts": {
		"Ability": "Reduce the Time cost of the third different shader you install by 3",
		"Affinity": "ART",
		"Inspiration": 25,
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
		"Ability": "The value requirement for 1st place is reduced by 3",
		"Affinity": "WIN",
		"Inspiration": 25,
	},
	"Networker": {
		"Ability": "Reduce the Kudos cost by 2 of the first Tutor, Collaborator or Contact you install per competition",
		"Affinity": "WIN",
		"Inspiration": 25,
	},
}

