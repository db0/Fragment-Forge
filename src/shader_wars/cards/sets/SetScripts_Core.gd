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
				"filter_token_count": 0,
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
		"Newbie Tutor": {
			"while_in_play": {
				"modify_costs": [
					{
						"name": "mod_counter",
						"counter_name": "cred",
						"modification": 1,
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
						"exec_trigger":  "manual",
						"exec_temp_mod_counters": {
							"skill": 1},
						"require_exec_state": "hand"
					},
				],
			},
		},
	}
	# We return only the scripts that match the card name and trigger
	return(scripts.get(card_name,{}))
