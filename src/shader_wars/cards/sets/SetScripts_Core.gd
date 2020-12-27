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
#					{
#						"name": "move_card_to_container",
#						"src_container": cfc.NMAP.hand,
#						"dest_container": cfc.NMAP.discard,
#						"subject": "self",
#					},
				],
			},
		},
#		"Advanced Shader": {
#			"card_moved_to_board": {
#				"board": [
#					{
#						"name": "modify_counter",
#						"counter": "time",
#						"modification": 10,
#					},
#				],
#				"trigger": "self",
#			},
#		},
	}
	# We return only the scripts that match the card name and trigger
	return(scripts.get(card_name,{}))
