# See README.md
extends Reference

# This fuction returns all the scripts of the specified card name.
#
# if no scripts have been defined, an empty dictionary is returned instead.
func get_scripts(card_name: String) -> Dictionary:
	var scripts := {
		"Google-Fu!": {
			"manual": {
				"hand": [
					# We have a function to discard manually to ensure
					# it's not counted for checking if the hand is full
					{
						"name": "move_card_to_container",
						"dest_container": cfc.NMAP.discard,
						"subject": "self",
					},
					{
						"name": "move_card_to_container",
						"src_container": cfc.NMAP.deck,
						"dest_container": cfc.NMAP.hand,
						"subject_count": 3,
						"subject": "index",
						"subject_index": "top",
					},
				],
			},
		},
		"Discord Mod": {
			"card_moved_to_board": {
				"board": [
					{
						"name": "mod_tokens",
						"modification": 12,
						"token_name": "kudos",
						"subject": "self"
					},
				],
				"trigger": "self",
			},
			"manual": {
				"board": [
					{
						"name": "mod_counter",
						"modification": -1,
						"counter_name": "time",
						"is_cost": true,
					},
					{
						"name": "mod_tokens",
						"modification": -2,
						"token_name": "kudos",
						"is_cost": true,
						"subject": "self"
					},
					{
						"name": "mod_counter",
						"modification": 2,
						"counter_name": "kudos",
					},
				],
			},
			"card_token_modified": {
				"board": [
					{
						"name": "move_card_to_container",
						"dest_container": cfc.NMAP.discard,
						"subject": "self"
					},
				],
				"trigger": "self",
				"filter_token_name": "kudos",
				"filter_count": 0,
			},
		},
		"Massive Compression": {
			"manual": {
				"hand": [
					{
						"name": "mod_counter",
						"counter_name": "cred",
						"modification": 1,
					},
				],
			},
		},
		"Meditation": {
			"manual": {
				"hand": [
					{
						"name": "mod_counter",
						"counter_name": "motivation",
						"modification": 1,
					},
				],
			},
		},
		"Help out Some Newbs": {
			"manual": {
				"hand": [
					{
						"name": "mod_counter",
						"counter_name": "kudos",
						"modification": 4,
					},
				],
			},
		},
		"Vectornator": {
			"competition_ended": {
				"board": [
					{
						"name": "move_card_to_container",
						"dest_container": cfc.NMAP.discard,
						"subject": "self"
					},
				],
			},
			"alterants": {
				"board": [
					{
						"filter_task": "get_demo_value",
						"alteration": 6,
						"filter_per_boardseek_count": {
							"subject": "boardseek",
							"subject_count": "all",
							"filter_card_count": 2,
							"comparison": "ge",
							"filter_state_seek": [
								{"filter_properties": {
									"Type": "Shader",
									"skill_req": 1}}
							],
						}
					},
				],
			},
		},
		"Zhee": {
			"competition_ended": {
				"board": [
					{
						"name": "move_card_to_container",
						"dest_container": cfc.NMAP.discard,
						"subject": "self"
					},
				],
			},
			"alterants": {
				"board": [
					{
						"filter_task": "get_demo_value",
						"alteration": 5,
					},
				],
			},
		},
		"Prismatic": {
			"competition_ended": {
				"board": [
					{
						"name": "move_card_to_container",
						"dest_container": cfc.NMAP.discard,
						"subject": "self"
					},
				],
			},
			"alterants": {
				"board": [
					{
						"filter_task": "get_demo_value",
						"alteration": 8,
						"filter_prismatic": true
					},
				],
			},
		},
		"Cheerleader": {
			"competition_ended": {
				"board": [
					{
						"name": "mod_counter",
						"counter_name": "cred",
						"modification": 1,
					},
				],
				"filter_current_place": Competitions.Place.FIRST,
			},
			"card_moved_to_board": {
				"board": [
					{
						"name": "mod_counter",
						"modification": -1,
						"counter_name": "cred",
						"trigger": "self",
					},
				],
			},
		},
		"Mandelbrot": {
			"competition_ended": {
				"board": [
					{
						"name": "mod_counter",
						"counter_name": "motivation",
						"modification": -1,
					},
				],
				"filter_not_current_place": Competitions.Place.FIRST,
			},
		},
		"Topologica": {
			"competition_ended": {
				"board": [
					{
						"name": "mod_counter",
						"counter_name": "motivation",
						"modification": 1,
					},
				],
				"filter_current_place": Competitions.Place.FIRST,
			},
		},
		"Voronoi Column Tracing": {
			"card_moved_to_board": {
				"board": [
					{
						"name": "move_card_to_container",
						"src_container": cfc.NMAP.deck,
						"dest_container": cfc.NMAP.hand,
						"subject_count": 1,
						"subject": "index",
						"trigger": "self",
						"subject_index": "top",
					},
				],
			},
		},
		"Difios": {
			"alterants": {
				"board": [
					{
						"filter_task": "get_counter",
						"filter_counter_name": "skill",
						"alteration": 1,
						"filter_state_trigger": [
							{
								"filter_properties": {
									"Type": CardConfig.CardTypes.SHADER
								},
								"filter_properties2": {
									"skill_req": 1,
									"comparison": "le",
								}
							}
						]
					},
				],
			},
		},
		"Lachesis": {
			"alterants": {
				"board": [
					{
						"filter_task": "get_property",
						"trigger": "another",
						"filter_property_name": "Value",
						"alteration": 1,
						"filter_state_trigger": [
							{
								"filter_properties": {
									"Type": "Shader"
								},
								"filter_properties2": {
									"skill_req": 1,
									"comparison": "eq",
								}
							}
						]
					},
				],
			},
		},
		"Clotho": {
			"alterants": {
				"board": [
					{
						"filter_task": "get_property",
						"trigger": "another",
						"filter_property_name": "Value",
						"alteration": 1,
						"filter_state_trigger": [
							{
								"filter_properties": {
									"Type": "Shader"
								},
								"filter_properties2": {
									"skill_req": 0,
									"comparison": "eq",
								}
							}
						]
					},
				],
			},
		},
		"Atropos": {
			"alterants": {
				"board": [
					{
						"filter_task": "get_property",
						"trigger": "another",
						"filter_property_name": "Value",
						"alteration": 1,
						"filter_state_trigger": [
							{
								"filter_properties": {
									"Type": "Shader"
								},
								"filter_properties2": {
									"skill_req": 2,
									"comparison": "eq",
								}
							}
						]
					},
				],
			},
		},
		"Guru": {
			"alterants": {
				"board": [
					{
						"filter_task": "get_counter",
						"filter_counter_name": "skill",
						"alteration": 1,
						"filter_state_trigger": [
							{"filter_properties": {"Type": "Shader"}},
							{"filter_properties2": {
								"skill_req": 3,
								"comparison": "ge",
							}}
						]
					},
				],
			},
		},
		"Get Some Advice": {
			"manual": {
				"hand": [
					{
						"name": "execute_scripts",
						"subject": "target",
						"is_cost": true,
						"exec_trigger":  "manual",
						"temp_mod_counters": {
							"skill": 1},
						"require_exec_state": "hand",
						"filter_state_subject": [{
							"filter_properties": {"Type": "Shader"},
						}],
					},
				],
			},
		},
		"Monetary Incentives": {
			"manual": {
				"hand": [
					{
						"name": "mod_counter",
						"counter_name": "cred",
						"modification": -1,
						"is_cost": true
					},
					{
						"name": "execute_scripts",
						"subject": "target",
						"is_cost": true,
						"exec_trigger":  "manual",
						"temp_mod_counters": {
							"skill": 2},
						"require_exec_state": "hand",
						"filter_state_subject": [{
							"filter_properties": {"Type": "Shader"},
						}],
					},
				],
			},
		},
		"Enhance": {
			"manual": {
				"hand": [
					{
						"name": "execute_scripts",
						"subject": "target",
						"is_cost": true,
						"exec_trigger":  "manual",
						"temp_mod_properties": {
							"Time": 2},
						"require_exec_state": "hand",
						"filter_state_subject": [{
							"filter_properties": {"Type": "Shader"},
						}],
					},
					{
						"name": "modify_properties",
						"set_properties": {"Value": "+5"},
						"subject": "previous",
					},
				],
			},
		},
		"Crowdsourcing": {
			"manual": {
				"hand": [
					{
						"name": "mod_counter",
						"counter_name": "kudos",
						"modification": 0,
						"store_integer": true,
						"set_to_mod": true,
						"is_cost": true,
					},
					{
						"name": "execute_scripts",
						"subject": "target",
						"is_cost": true,
						"exec_trigger":  "manual",
						"temp_mod_properties": {
							"Time": "retrieve_integer"},
						"require_exec_state": "hand",
						"filter_state_subject": [{
							"filter_properties": {"Type": "Shader"},
						}],
					},
				],
			},
		},
		"Social Networking": {
			"manual": {
				"hand":[
					# This has to go before the move, or the check for
					# the parent will happen after the card is already
					# in the discard pile
					{
						"name": "mod_counter",
						"counter_name": "kudos",
						"modification": 3,
						"subject": "previous",
						"filter_state_subject": [
							{"filter_parent": cfc.NMAP.board},
						],
					},
					{
						"name": "move_card_to_container",
						"dest_container": cfc.NMAP.discard,
						"subject": "target",
						"is_cost": true,
						"filter_state_subject": [
							{"filter_properties1": {"Tags": "Tutor"}},
							{"filter_properties1": {"Tags": "Collaborator"}},
						],
					},
					{
						"name": "mod_counter",
						"counter_name": "cred",
						"modification": 1,
					},
					{
						"name": "mod_counter",
						"counter_name": "kudos",
						"modification": 2,
					},
				],
			},
		},
		"Private Forum Mod": {
			"manual": {
				"board": [
					{
						"name": "mod_counter",
						"counter_name": "time",
						"is_cost": true,
						"modification": -1,
					},
					{
						"name": "move_card_to_container",
						"src_container": cfc.NMAP.deck,
						"dest_container": cfc.NMAP.hand,
						"subject": "index",
						"subject_index": "top",
					},
					{
						"name": "mod_counter",
						"counter_name": "kudos",
						"modification": 1,
					},
				],
			},
		},
		"Junker": {
			"competition_ended": {
				"board": [
					{
						"name": "move_card_to_container",
						"dest_container": cfc.NMAP.discard,
						"subject": "self"
					},
				],
			},
		},
		"Collaboration": {
			"manual": {
				"hand": [
					{
						"name": "move_card_to_container",
						"dest_container": cfc.NMAP.discard,
						"subject": "target",
						"filter_state_subject": [{"filter_parent": cfc.NMAP.board}],
						"is_cost": true
					},
					{
						"name": "mod_counter",
						"counter_name": "kudos",
						"modification": "per_property",
						"subject": "previous",
						"per_property": {
							"subject": "previous",
							"property_name": "Value"}
					},
				],
			},
		},
		"Search Engine Expertise": {
			"manual": {
				"board": {
					"Once per turn, Look at the top card of the deck": [
						{
							"name": "rotate_card",
							"subject": "self",
							"degrees": 90,
							"is_cost": true
						},
						{
							"name": "view_card",
							"src_container": cfc.NMAP.deck,
							"subject": "index",
							"subject_index": "top"
						},
					],
					"Discard to draw a card": [
						{
							"name": "move_card_to_container",
							"dest_container": cfc.NMAP.discard,
							"subject": "self",
						},
						{
							"name": "move_card_to_container",
							"src_container": cfc.NMAP.deck,
							"dest_container": cfc.NMAP.hand,
							"subject_count": 1,
							"subject": "index",
							"subject_index": "top",
						},
					],
				},
			},
		},
		"Sierpinski": {
			"card_moved_to_board": {
				"board": [
					{
						"name": "mod_tokens",
						"modification": 1,
						"token_name": "activation",
						"subject": "self",
						"trigger": "self",
					},
					{
						"name": "mod_tokens",
						"modification": -1,
						"token_name": "activation",
						"subject": "self",
						"trigger": "another",
						"is_cost": true,
						"filter_state_trigger": [
							{
								"filter_properties": \
										{"Type": CardConfig.CardTypes.SHADER},
							}
						],
					},
					{
						"name": "modify_properties",
						"set_properties": {"Value": "+3"},
						"subject": "trigger",
						"trigger": "another",
						"filter_state_trigger": [
							{
								"filter_properties": \
										{"Type": CardConfig.CardTypes.SHADER},
							}
						],
					},
				],
			},
		},
		"Fractal Tiling": {
			"card_moved_to_board": {
				"board": [
					{
						"name": "move_card_to_container",
						"dest_container": cfc.NMAP.discard,
						"src_container": cfc.NMAP.hand,
						"subject": "index",
						"trigger": "self",
						"subject_index": "random",
					},
				],
			},
		},
		"Xod": {
			"card_moved_to_board": {
				"board": [
					{
						"name": "move_card_to_container",
						"dest_container": cfc.NMAP.discard,
						"subject": "target",
						"trigger": "self",
						"is_cost": true,
						"filter_state_subject": [{
							"filter_properties": {"Type": CardConfig.CardTypes.SHADER},
							"filter_parent": cfc.NMAP.board
						}],
					},
					{
						"name": "move_card_to_container",
						"dest_container": cfc.NMAP.discard,
						"subject": "self",
						"trigger": "self",
						"is_else": true,
					},
				],
			},
		},
		"Lanterns": {
			"card_moved_to_board": {
				"board": [
					{
						"name": "rotate_card",
						"degrees": 0,
						"subject": "target",
						"trigger": "self",
						"filter_state_subject": [
							{
								"filter_properties1": {"Type": CardConfig.CardTypes.RESOURCE},
								"filter_properties2": {"Tags": "Tutor"},
								"filter_parent": cfc.NMAP.board,
							},
							{
								"filter_properties1": {"Type": CardConfig.CardTypes.RESOURCE},
								"filter_properties2": {"Tags": "Collaborator"},
								"filter_parent": cfc.NMAP.board,
							}
						],
					},
				],
			},
		},
		"Creative Block": {
			"card_moved_to_hand": {
				"hand": [
					{
						"name": "move_card_to_container",
						"src_container": cfc.NMAP.deck,
						"dest_container": cfc.NMAP.hand,
						"subject_count": 1,
						"subject": "index",
						"trigger": "self",
						"subject_index": "top",
					},
				],
			"filter_source": cfc.NMAP.deck,
			},
			"card_moved_to_pile": {
				"discard": [
					{
						"name": "move_card_to_container",
						"src_container": cfc.NMAP.deck,
						"dest_container": cfc.NMAP.hand,
						"subject_count": 3,
						"subject": "index",
						"trigger": "self",
						"subject_index": "top",
					},
				],
			"filter_source": cfc.NMAP.hand,
			"filter_destination": cfc.NMAP.discard
			},
		},
		"Sculpture": {
			"card_moved_to_hand": {
				"hand": [
					{
						"name": "move_card_to_container",
						"src_container": cfc.NMAP.deck,
						"dest_container": cfc.NMAP.discard,
						"subject": "self",
						"trigger": "self",
					},
				],
			"filter_source": cfc.NMAP.deck,
			"filter_tags": "Scripted",
			},
		},
		"Presentation": {
			"manual": {
				"hand": [
					{
						"name": "mod_counter",
						"modification": "per_boardseek",
						"counter_name":  "kudos",
						"per_boardseek": {
							"subject": "boardseek",
							"subject_count": "all",
							"filter_state_seek": [
								{"filter_properties": {
									"Type": CardConfig.CardTypes.SHADER}
								}
							]
						}
					},
				],
			},
		},
		"Pivot": {
			"manual": {
				"hand": [
					{
						"name": "mod_counter",
						"modification": "per_boardseek",
						"counter_name":  "kudos",
						"is_cost": true,
						"per_boardseek": {
							"is_inverted": true,
							"subject": "boardseek",
							"subject_count": "all",
							"filter_state_seek": [
								{"filter_properties": {
									"Type": CardConfig.CardTypes.SHADER}
								}
							]
						}
					},
					{
						"name": "move_card_to_container",
						"dest_container": cfc.NMAP.discard,
						"subject": "self",
					},
					{
						"name": "move_card_to_container",
						"src_container": cfc.NMAP.deck,
						"dest_container": cfc.NMAP.hand,
						"subject_count": "per_boardseek",
						"subject": "index",
						"subject_index": "top",
						"per_boardseek": {
							"subject": "boardseek",
							"subject_count": "all",
							"filter_state_seek": [
								{"filter_properties": {
									"Type": CardConfig.CardTypes.SHADER}
								}
							]
						}
					},
				],
			},
		},
		"Fresh Start": {
			"manual": {
				"hand": [
					{
						"name": "move_card_to_container",
						"src_container": cfc.NMAP.hand,
						"dest_container": cfc.NMAP.discard,
						"subject_count": "all",
						"subject": "index",
						"subject_index": "top",
					},
					{
						"name": "move_card_to_container",
						"src_container": cfc.NMAP.deck,
						"dest_container": cfc.NMAP.hand,
						"subject_count": "per_counter",
						"subject": "index",
						"subject_index": "top",
						"per_counter": {
							"counter_name": "motivation"}
					},
				],
			},
		},
		"All-Nighter": {
			"manual": {
				"hand": [
					{
						"name": "move_card_to_container",
						"dest_container": cfc.NMAP.discard,
						"subject": "self",
					},
					{
						"name": "custom_script",
					},
					{
						"name": "mod_counter",
						"modification": -1,
						"counter_name": "motivation",
					},
				],
			},
		},
		"Refactoring": {
			"manual": {
				"hand": [
					{
						"name": "mod_counter",
						"modification": -1,
						"is_cost": true,
						"counter_name": "motivation",
					},
					{
						"name": "move_card_to_container",
						"dest_container": cfc.NMAP.discard,
						"subject": "target",
						"is_cost": true,
						"filter_state_subject": [{
							"filter_properties": {"Type": CardConfig.CardTypes.SHADER},
							"filter_parent": cfc.NMAP.board
						}],
					},
					{
						"name": "custom_script",
						"subject": "previous",
					},
				],
			},
		},
		"Plasma Globe": {
			"card_moved_to_board": {
				"board": [
					{
						"name": "mod_counter",
						"modification": -1,
						"counter_name": "motivation",
						"trigger": "self",
					},
				],
			},
		},
		"Noise Pulse": {
			"card_moved_to_board": {
				"board": [
					{
						"name": "modify_properties",
						"set_properties": {"Value": "+1"},
						"subject": "self",
						"trigger": "another",
						"filter_state_trigger": [
							{"filter_properties": {"Tags": "Tutor"}},
							{"filter_properties": {"Tags": "Collaborator"}},
						],
					},
				],
			},
		},
		"CompSci Degree": {
			"card_moved_to_board": {
				"board": [
					{
						"name": "move_card_to_container",
						"src_container": cfc.NMAP.deck,
						"dest_container": cfc.NMAP.hand,
						"subject_count": 1,
						"subject": "index",
						"subject_index": "top",
						"trigger": "another",
						"filter_state_trigger": [
							{"filter_properties": {"Tags": "Tutor"}},
							{"filter_properties": {"Tags": "Collaborator"}},
						],
					},
				],
			},
		},
		"Ether": {
			"card_moved_to_board": {
				"board": [
					{
						"name": "move_card_to_container",
						"subject": "tutor",
						"src_container":  cfc.NMAP.deck,
						"dest_container":  cfc.NMAP.hand,
						"filter_state_tutor": [
							{
								"filter_properties": {
									"Tags": "Collaborator"
								}
							}
						],
						"trigger": "self",
					},
				],
			},
		},
		"Spine": {
			"alterants": {
				"board": [
					{
						"filter_task": "get_property",
						"trigger": "self",
						"filter_property_name": "Value",
						"alteration": "per_boardseek",
						"per_boardseek": {
							"is_inverted": true,
							"subject": "boardseek",
							"subject_count": "all",
							"filter_state_seek": [
								{
									"filter_properties": {
										"Type": CardConfig.CardTypes.SHADER
									}
								}
							]
						}
					},
				]
			}
		},
		"Apollonian": {
			"manual": {
				"board": [
					{
						"name": "mod_counter",
						"counter_name": "time",
						"is_cost": true,
						"modification": -2,
					},
					{
						"name": "rotate_card",
						"degrees": 90,
						"is_cost": true,
						"subject": "self",
					},
					{
						"name": "modify_properties",
						"set_properties": {"Value": "+2"},
						"subject": "self",
					},
				]
			}
		},
		"Echo": {
			"manual": {
				"board": [
					{
						"name": "rotate_card",
						"degrees": 90,
						"is_cost": true,
						"subject": "self",
					},
					{
						"name": "modify_properties",
						"set_properties": {"Value": "+2"},
						"subject": "target",
						"filter_state_subject": [{
							"filter_properties": {"Type": "Shader"},
							"filter_parent": cfc.NMAP.board
						}],
					},
				]
			}
		},
		"Hardcode": {
			"card_moved_to_board": {
				"board": [
					{
						"name": "mod_counter",
						"counter_name": "time",
						"modification": 1,
						"trigger": "another",
						"filter_state_trigger": [
							{
								"filter_properties": {"Type": "Shader"},
								"filter_properties2": {
									"skill_req": "skill",
									"comparison": 'gt',
								},
							}
						],
					},
				],
			},
		},
		"Git": {
			"card_moved_to_board": {
				"board": [
					{
						"name": "move_card_to_container",
						"src_container": cfc.NMAP.deck,
						"dest_container": cfc.NMAP.hand,
						"subject_count": 1,
						"subject": "index",
						"subject_index": "top",
						"trigger": "another",
						"filter_state_trigger": [
							{"filter_properties": {"Type": "Shader"}},
						],
					},
				],
				"filter_per_boardseek_count": {
					"subject": "boardseek",
					"subject_count": "all",
					"filter_state_seek": [
						{"filter_properties": {"Type": "Shader"}}
					],
					"filter_card_count": 4}
			},
		},
		"Insight": {
			"manual": {
				"hand": [
					{
						"name": "move_card_to_container",
						"dest_container": cfc.NMAP.discard,
						"subject": "target",
						"is_cost": true,
						"filter_state_subject": [
							{
								"filter_properties": {"Type": "Shader"},
								"filter_parent": cfc.NMAP.hand
							},
						],
					},
					{
						"name": "mod_counter",
						"modification": 6,
						"counter_name": "time",
					},
				],
			},
		},
		"A3sop": {
			"manual": {
				"board": [
					{
						"name": "rotate_card",
						"subject": "self",
						"degrees": 90,
						"is_cost": true
					},
					{
						"name": "move_card_to_container",
						"dest_container": cfc.NMAP.hand,
						"subject": "target",
						"is_cost": true,
						"filter_state_subject": [
							{
								"filter_properties": {"Type": "Shader"},
								"filter_parent": cfc.NMAP.board
							},
						],
					},
					{
						"name": "mod_counter",
						"modification": "per_property",
						"counter_name": "time",
						"subject": "previous",
						"per_property": {
							"subject": "previous",
							"property_name": "Time"}
					},
				],
			},
		},
		"Runes": {
			"card_moved_to_board": {
				"discard": [
					{
						"name": "move_card_to_board",
						"subject": "self",
						"grid_name": "Shaders",
						"trigger": "another",
						"filter_state_trigger": [
							{
								"filter_properties": \
										{"Type": CardConfig.CardTypes.SHADER},
							}
						],
					},
				],
			},
		},
		"Math Degree": {
			"manual": {
				"board": [
					{
						"name": "rotate_card",
						"subject": "self",
						"degrees": 90,
						"is_cost": true
					},
					{
						"name": "mod_counter",
						"counter_name": "kudos",
						"is_cost": true,
						"modification": -1,
					},
					{
						"name": "move_card_to_container",
						"subject": "tutor",
						"src_container":  cfc.NMAP.discard,
						"dest_container":  cfc.NMAP.hand,
						"filter_state_tutor": [
							{
								"filter_properties": \
										{"Type": CardConfig.CardTypes.SHADER},
							}
						],
					},
				],
			},
		},
		"Blog": {
			"manual": {
				"board": [
					{
						"name": "rotate_card",
						"subject": "self",
						"degrees": 90,
						"is_cost": true
					},
					{
						"name": "move_card_to_container",
						"dest_container": cfc.NMAP.discard,
						"subject": "target",
						"is_cost": true,
						"filter_state_subject": [
							{
								"filter_parent": cfc.NMAP.board
							},
						],
					},
					{
						"name": "mod_counter",
						"modification": 4,
						"counter_name": "kudos",
					},
				],
			},
		},
		"Flux Core": {
			   "alterants": {
					   "hand": [
							{
								"filter_task": "get_property",
								"trigger": "self",
								"filter_property_name": "skill_req",
								"alteration": "per_boardseek",
								"per_boardseek": {
									"is_inverted": true,
									"subject": "boardseek",
									"subject_count": "all",
									"filter_state_seek": [
									{
										"filter_properties": {
										"Tags": "Tutor"
									}
								}
							]
						}
					},
				]
			}
		},
		"Liquid Bubbles": {
			"card_moved_to_board": {
				"board": [
					{
						"name": "modify_properties",
						"set_properties": {"Value": "+2"},
						"subject": "self",
						"trigger": "self",
						"filter_first": true,
					},
				],
			},
		},
		"Barberella": {
			"card_moved_to_board": {
				"board": [
					{
						"name": "modify_properties",
						"set_properties": {"Value": "-2"},
						"subject": "self",
						"trigger": "another",
						"filter_state_trigger": [
							{
								"filter_properties": \
										{"Type": CardConfig.CardTypes.SHADER},
							}
						],
					},
				],
			},
		},
		"Fidazzia": {
			"alterants": {
				"board": [
					{
						"filter_task": "modify_properties",
						"alteration": 1,
						"trigger": "another",
						"filter_property_name": "Value",
						"filter_count_difference": "increased",
					},
				],
			},
		},
		"Antisocial": {
			"manual": {
				"hand": [
					{
						"name": "mod_counter",
						"counter_name": "kudos",
						"modification": 0,
						"set_to_mod": true,
					},
					{
						"name": "mod_counter",
						"modification": +2,
						"counter_name": "motivation",
					},
				],
			},
			"alterants": {
				"board": [
					{
						"filter_task": "get_property",
						"filter_property_name": "Time",
						"alteration": +1000,
						"filter_state_trigger": [
							{"filter_properties": {"Tags": "Tutor"}},
							{"filter_properties": {"Tags": "Collaborator"}},
						]
					},
				],
			},
		},
		"Always Online": {
			"manual": {
				"board": [
					{
						"name": "rotate_card",
						"degrees": 90,
						"is_cost": true,
						"subject": "self",
					},
					{
						"name": "mod_counter",
						"modification": -1,
						"counter_name": "motivation",
						"is_cost": true,
					},
					{
						"name": "mod_counter",
						"modification": 3,
						"counter_name": "kudos",
					},
					{
						"name": "move_card_to_container",
						"src_container": cfc.NMAP.deck,
						"dest_container": cfc.NMAP.hand,
						"subject_count": 1,
						"subject": "index",
						"subject_index": "top",
					},
				]
			}
		},
		"Streaming": {
			"alterants": {
				"board": [
					{
						# By default, get_counter alterants will not work
						# for winning the game
						"filter_task": "get_counter",
						"filter_counter_name": "cred",
						"alteration": 1,
					},
				],
			},
		},
		"Podcast": {
			"alterants": {
				"board": [
					{
						# By default, get_counter alterants will not work
						# for winning the game
						"filter_task": "get_counter",
						"filter_counter_name": "motivation",
						"alteration": 1,
					},
				],
			},
		},
		"CC License": {
			"manual": {
				"board":[
					{
						"name": "mod_counter",
						"counter_name": "time",
						"modification": -1,
						"is_cost": true,
					},
					{
						"name": "rotate_card",
						"subject": "target",
						"degrees": 90,
						"is_cost": true,
						"filter_state_subject": [
							{
								"filter_parent": cfc.NMAP.board,
								"filter_properties": {
									"Type": CardConfig.CardTypes.SHADER
								},
							},
						],
					},
					{
						"name": "mod_counter",
						"counter_name": "kudos",
						"modification": 3,
					},
				],
			},
		},
		"Infinite Shader": {
			"card_moved_to_board": {
				"board": [
					{
						"name": "mod_counter",
						"trigger": "self",
						"modification": 0,
						"counter_name": "time",
						"set_to_mod": true
					},
				],
			},
		},
		"Multifaceted Shader": {
			"alterants": {
				"board": [
					{
						"filter_task": "get_property",
						"trigger": "self",
						"filter_property_name": "Value",
						"alteration": "per_boardseek",
						"per_boardseek": {
							"subject": "boardseek",
							"subject_count": "all",
							"count_unique": true,
							"filter_state_seek": [
								{
									"filter_properties": {
										"Type": CardConfig.CardTypes.SHADER
									}
								}
							]
						}
					},
				]
			}
		},
		"Daemonic Shader": {
			"card_moved_to_board": {
				"board": [
					{
						"name": "move_card_to_container",
						"subject": "tutor",
						"trigger": "self",
						"src_container":  cfc.NMAP.deck,
						"dest_container":  cfc.NMAP.hand,
						"sort_by": "property",
						"sort_name": "Value",
						"sort_descending": true,
						"filter_state_tutor": [
							{
								"filter_properties": \
										{"Type": CardConfig.CardTypes.SHADER},
							}
						],
					},
				]
			}
		},
		"Teaching Shader": {
			"card_moved_to_board": {
				"board": [
					{
						"name": "mod_counter",
						"modification": 3,
						"counter_name": "kudos",
						"trigger": "self",
					},
				]
			}
		},
		"Point Tunnel": {
			"competition_ended": {
				"board": [
					{
						"name": "move_card_to_container",
						"subject": "self",
						"dest_container":  cfc.NMAP.hand,
					},
				],
				"filter_current_place": Competitions.Place.FIRST,
			},
		},
		"Refreshing Shader": {
			"card_moved_to_board": {
				"board": [
					{
						"name": "rotate_card",
						"degrees": 0,
						"subject": "target",
						"trigger": "self",
						"filter_state_subject": [
							{
								"filter_properties1": {"Type": CardConfig.CardTypes.SHADER},
								"filter_parent": cfc.NMAP.board,
							},
						],
					},
				],
			},
		},
		"Cantrip Shader": {
			"card_moved_to_board": {
				"deck": [
					{
						"name": "move_card_to_container",
						"subject": "self",
						"trigger": "another",
						"dest_container":  cfc.NMAP.hand,
						"filter_per_boardseek_count": {
							"subject": "boardseek",
							"subject_count": "all",
							"count_unique": true,
							"filter_state_seek": [{
								"filter_properties": {"Type": CardConfig.CardTypes.SHADER}
							}],
							"filter_card_count": 3,}
					},
				]
			}
		},
		"Star Nest": {
			"card_moved_to_board": {
				"board": [
					{
						"name": "move_card_to_container",
						"subject": "tutor",
						"trigger": "self",
						"src_container":  cfc.NMAP.discard,
						"dest_container":  cfc.NMAP.hand,
						"filter_state_tutor": [
							{
								"filter_properties": {
									"Type": CardConfig.CardTypes.ACTION
								}
							}
						],
					},
				],
			},
		},
		"Planet": {
			"card_moved_to_board": {
				"board": [
					{
						"name": "mod_counter",
						"counter_name": "cred",
						"modification": 1,
						"trigger": "self",
					},
				],
			},
		},
		"Explorer": {
			"alterants": {
				"hand": [
					{
						"filter_task": "get_property",
						"trigger": "self",
						"filter_property_name": "Time",
						"alteration": "custom_script",
					},
				]
			}
		},
		"Methodical": {
			"card_moved_to_hand": {
				"board": [
					{
						"name": "mod_counter",
						"modification": -1,
						"counter_name": "time",
						"trigger": "another",
					},
				],
			"filter_source": cfc.NMAP.deck,
			"filter_tags": "Scripted",
			},
			"card_rotated": {
				"board": [
					{
						"name": "mod_counter",
						"modification": 1,
						"counter_name": "time",
						"trigger": "another",
					},
				],
				"filter_state_trigger": [
					{
						"filter_properties": {
							"Type": CardConfig.CardTypes.SHADER
						},
					}
				]
			},
		},
		"Lost in the Moment": {
			"manual": {
				"hand": [
					{
						"name": "modify_properties",
						"set_properties": {"Value": "+per_property"},
						"subject": "boardseek",
						"subject_count": 1,
						"sort_by": "property",
						"sort_name": "Value",
						"per_property": {
							"subject": "boardseek",
							"subject_count": 1,
							"sort_by": "property",
							"sort_name": "Value",
							"property_name": "Value",
							"filter_state_seek": [
								{
									"filter_properties": \
											{"Type": CardConfig.CardTypes.SHADER},
								}
							],
						},
						"filter_state_seek": [
							{
								"filter_properties": \
										{"Type": CardConfig.CardTypes.SHADER},
							}
						],
					},
					{
						"name": "mod_counter",
						"modification": 0,
						"counter_name": "time",
						"set_to_mod": true
					},
				],
			},
		},
		"Vision": {
			"competition_ended": {
				"board": [
					{
						"name": "move_card_to_container",
						"dest_container": cfc.NMAP.discard,
						"subject": "self"
					},
				],
			},
			"alterants": {
				"board": [
					{
						"filter_task": "get_demo_value",
						"alteration": 8,
						"filter_per_boardseek_count": {
							"subject": "boardseek",
							"subject_count": "all",
							"filter_card_count": 5,
							"comparison": "ge",
							"filter_state_seek": [
								{"filter_properties": {
									"Type": CardConfig.CardTypes.SHADER
								}}
							],
						}
					},
				],
			},
		},
		"Art Degree": {
			"manual": {
				"board": [
					{
						"name": "rotate_card",
						"subject": "self",
						"degrees": 90,
						"is_cost": true
					},
					{
						"name": "mod_counter",
						"modification": -2,
						"counter_name": "time",
						"is_cost": true,
					},
					{
						"name": "move_card_to_board",
						"grid_name": "Shaders",
						"subject": "tutor",
						"src_container":  cfc.NMAP.deck,
						"filter_state_tutor": [
							{
								"filter_properties": {
									"Type": CardConfig.CardTypes.SHADER
								}
							}
						],
					},
					{
						"name": "flip_card",
						"subject": "previous",
						"set_faceup": true
					},
					{
						"name": "mod_counter",
						"trigger": "self",
						"modification": 0,
						"counter_name": "time",
						"set_to_mod": true
					},
				],
			},
		},
		"Igorrr": {
			"competition_ended": {
				"board": [
					{
						"name": "move_card_to_container",
						"dest_container": cfc.NMAP.discard,
						"subject": "self"
					},
				],
			},
			"alterants": {
				"board": [
					{
						"filter_task": "get_demo_value",
						"alteration": 8,
						"filter_per_counter": {
							"filter_count": 3,
							"comparison": "le",
							"counter_name": "motivation",
						}
					},
				],
			},
		},
		"Silver Tongue": {
			"alterants": {
				"board": [
					{
						"filter_task": "get_property",
						"filter_property_name": "Kudos",
						"alteration": -1,
						"filter_state_trigger": [
							{"filter_properties": {"Tags": "Tutor"}},
							{"filter_properties": {"Tags": "Collaborator"}},
						]
					},
				],
			},
		},
		"Xeger": {
			"manual": {
				"board": {
					"Exhaust a Shader": [
						{
							"name": "mod_counter",
							"modification": -2,
							"counter_name": "kudos",
							"is_cost": true
						},
						{
							"name": "rotate_card",
							"degrees": 90,
							"subject": "target",
							"is_cost": true,
							"filter_state_subject": [
								{
									"filter_properties1": {"Type": CardConfig.CardTypes.SHADER},
									"filter_parent": cfc.NMAP.board,
								},
							],
						},
					],
					"Unexhaust a Shader": [
						{
							"name": "mod_counter",
							"modification": -2,
							"counter_name": "kudos",
							"is_cost": true
						},
						{
							"name": "rotate_card",
							"degrees": 0,
							"subject": "target",
							"is_cost": true,
							"filter_state_subject": [
								{
									"filter_properties1": {"Type": CardConfig.CardTypes.SHADER},
									"filter_parent": cfc.NMAP.board,
								},
							],
						},
					],
				},
			},
		},
		"Twitter": {
			"counter_modified": {
				"board": [
					{
						"name": "mod_counter",
						"modification": 2,
						"counter_name": "kudos",
					},
				],
				"filter_counter_name": "cred",
				"filter_count_difference": "increased"
			},
		},
		"Constant": {
			"alterants": {
				"board": [
					{
						"filter_task": "get_counter",
						"filter_counter_name": "skill",
						"alteration": "per_boardseek",
						"filter_state_trigger": [
							{
								"filter_properties": {
									"Type": CardConfig.CardTypes.SHADER
								},
							}
						],
						"per_boardseek": {
							"subject": "boardseek",
							"subject_count": "all",
							"filter_state_seek": [
								{
									"filter_properties": {
										"Name": SP.VALUE_COMPARE_WITH_TRIGGER
									}
								}
							]
						}
					},
				],
			},
		},
		"Inner Circle": {
			"manual": {
				"board": {
					"Exhaust: Add an Activation Token": [
						{
							"name": "rotate_card",
							"subject": "self",
							"degrees": 90,
							"is_cost": true
						},
						{
							"name": "mod_tokens",
							"modification": 1,
							"token_name": "activation",
							"subject": "self"
						},
					],
					"2 Kudos: Add an Activation Token": [
						{
							"name": "mod_counter",
							"modification": -2,
							"counter_name": "kudos",
							"is_cost": true,
						},
						{
							"name": "mod_tokens",
							"modification": 1,
							"token_name": "activation",
							"subject": "self"
						},
					],
					"Discard: Reduce the 1st place requirements by the number of activation tokens": [
						{
							"name": "mod_competition",
							"place": Competitions.Place.FIRST,
							"modification": "per_token",
							"per_token": {
								"subject": "self",
								"token_name": "activation",
								"is_inverted": true,
							},
						},
						{
							"name": "move_card_to_container",
							"dest_container": cfc.NMAP.discard,
							"subject": "self",
						},
					],
				},
			},
		},
		"Connected": {
			"manual": {
				"board": [
					{
						"name": "rotate_card",
						"subject": "self",
						"degrees": 90,
						"is_cost": true
					},
					{
						"name": "mod_counter",
						"modification": "per_boardseek",
						"counter_name":  "kudos",
						"per_boardseek": {
							"subject": "boardseek",
							"subject_count": "all",
							"filter_state_seek": [
								{"filter_properties": {"Tags": "Tutor"}},
								{"filter_properties": {"Tags": "Collaborator"}},
								{"filter_properties": {"Tags": "Contact"}},
							],
						}
					},
				],
			},
		},
		"Compacting Run": {
			"manual": {
				"hand": [
					{
						"name": "mod_counter",
						"counter_name": "kudos",
						"modification": 3,
					},

				]
			},
			"card_moved_to_pile": {
				"discard": [
					{
						"name": "move_card_to_container",
						"dest_container": cfc.NMAP.hand,
						"subject": "self",
						"trigger": "another",
						"filter_state_trigger": [
							{
								"filter_properties": \
										{"Type": CardConfig.CardTypes.ACTION},
								"filter_tags": "Played",
							}
						],
					},
				],
			},
		},
		"Versatility": {
			"manual": {
				"hand": {
					"Gain 2 Kudos": [
						{
							"name": "mod_counter",
							"counter_name": "kudos",
							"modification": 2,
						},
					],
					"Unexhaust a Shader": [
						{
							"name": "rotate_card",
							"degrees": 0,
							"subject": "target",
							"filter_state_subject": [
								{
									"filter_properties1": {"Type": CardConfig.CardTypes.SHADER},
									"filter_parent": cfc.NMAP.board,
								},
							],
						},
					],
				},
			},
		},
		"Polishing": {
			"manual": {
				"hand": [
					{
						"name": "modify_properties",
						"set_properties": {"Value": "+4"},
						"subject": "target",
						"filter_state_subject": [{
							"filter_properties": {"Type": "Shader"},
							"filter_parent": cfc.NMAP.board
						}],
					},
				]
			}
		},
		"Common Shader": {
			"manual": {
				"board": [
					{
						"name": "mod_counter",
						"counter_name": "kudos",
						"is_cost": true,
						"modification": -5,
					},
					{
						"name": "modify_properties",
						"set_properties": {"Value": "+2"},
						"subject": "self",
					},
				]
			}
		},
		"Suru": {
			"manual": {
				"board": [
					{
						"name": "rotate_card",
						"subject": "self",
						"degrees": 90,
						"is_cost": true
					},
					{
						"name": "mod_counter",
						"modification": -2,
						"counter_name": "kudos",
						"is_cost": true
					},
					{
						"name": "mod_tokens",
						"modification": 1,
						"token_name": "activation",
						"subject": "self"
					},
				],
			},
			"card_moved_to_board": {
				"board": [
					{
						"name": "mod_tokens",
						"modification": 0,
						"set_to_mod": true,
						"token_name": "activation",
						"subject": "self",
						"trigger": "another",
						"filter_state_trigger": [
							{
								"filter_properties": \
										{"Type": CardConfig.CardTypes.SHADER},
							}
						],
					},
				],
			},
			"alterants": {
				"board": [
					{
						"filter_task": "get_counter",
						"filter_counter_name": "skill",
						"alteration": "per_token",
						"filter_state_trigger": [
							{
								"filter_properties": {
									"Type": CardConfig.CardTypes.SHADER
								},
							}
						],
						"per_token": {
							"subject": "self",
							"token_name": "activation",
						}
					},
				],
			},
		},
		"Ideas Exchange": {
			"manual": {
				"hand":[
					# We have a function to discard manually to ensure
					# it's not counted for checking if the hand is full
					{
						"name": "move_card_to_container",
						"dest_container": cfc.NMAP.discard,
						"subject": "target",
						"is_cost": true,
					},
					{
						"name": "move_card_to_container",
						"dest_container": cfc.NMAP.discard,
						"subject": "self",
					},
					{
						"name": "move_card_to_container",
						"src_container": cfc.NMAP.deck,
						"dest_container": cfc.NMAP.hand,
						"subject_count": 3,
						"subject": "index",
						"subject_index": "top",
					},
				],
			},
		},
	}
	# We return only the scripts that match the card name and trigger
	return(scripts.get(card_name,{}))
