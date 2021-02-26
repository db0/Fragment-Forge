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
		"Post Some Progress": {
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
						"modification": 3,
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
						"alteration": 5,
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
									"Type": "Shader"
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
							{"filter_properties1": {"Tags": "Volunteering"}},
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
		"Hacking Buddy": {
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
						"filter_task": "get_property",
						"filter_property_name": "Time",
						"alteration": -1,
						"filter_state_trigger": [
							{"filter_properties": {
								"Type": "Shader",
							}}
						]
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
						"set_properties": {"Value": "+2"},
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
				"pile": [
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
		"Silver Tongue": {
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
		"Boost Shader": {
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
						"set_properties": {"Value": "+1"},
						"subject": "target",
						"filter_state_subject": [{
							"filter_properties": {"Type": "Shader"},
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
		"Undead Shader": {
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
	}
	# We return only the scripts that match the card name and trigger
	return(scripts.get(card_name,{}))
