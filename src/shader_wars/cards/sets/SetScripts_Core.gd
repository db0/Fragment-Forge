# See README.md
extends Reference

# This fuction returns all the scripts of the specified card name.
#
# if no scripts have been defined, an empty dictionary is returned instead.
func get_scripts(card_name: String) -> Dictionary:
	var scripts := {
		"Circle Shader": {
			"card_moved_to_board": {
				"board": [
					{
						"name": "modify_counter",
						"counter": "time",
						"modification": -3,
					},
				],
				"trigger": "self",
			},
		},
		"Advanced Shader": {
			"card_moved_to_board": {
				"board": [
					{
						"name": "modify_counter",
						"counter": "time",
						"modification": 10,
					},
				],
				"trigger": "self",
			},
		},
	}
	# We return only the scripts that match the card name and trigger
	return(scripts.get(card_name,{}))
