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
		"Graphics Artist": {
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
		"Chiptunes Musician": {
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
		"Newbie Tutor": {
			"alterants": {
				"board": [
					{
						"filter_task": "get_counter",
						"filter_counter_name": "skill",
						"alteration": 1,
						"filter_state_trigger": [
							{"filter_properties": {
								"Type": "Shader",
								"skill_req": 1
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
						SP.KEY_DEST_CONTAINER: cfc.NMAP.discard,
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
	}
	# We return only the scripts that match the card name and trigger
	return(scripts.get(card_name,{}))
