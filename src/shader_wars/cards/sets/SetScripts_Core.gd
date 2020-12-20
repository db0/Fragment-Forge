# See README.md
extends Reference

# This fuction returns all the scripts of the specified card name.
#
# if no scripts have been defined, an empty dictionary is returned instead.
func get_scripts(card_name: String) -> Dictionary:
	var scripts := {
		"Circle Shader": {
			"manual": {
				"hand": [
					{
						"name": "modify_counter",
						"counter": "time",
						"is_cost": true,
						"modification": -3,
					},
					{
						"name": "move_card_to_board",
						"subject": "self",
						"board_position": Vector2(500,100),
					}
				]
			},
		},
		"Advanced Shader": {
			"manual": {
				"hand": [
					{
						"name": "modify_counter",
						"counter": "time",
						"modification": 10,
					},
					{
						"name": "move_card_to_board",
						"subject": "self",
						"board_position": Vector2(100,100),
					}
				]
			},
		},
	}
	# We return only the scripts that match the card name and trigger
	return(scripts.get(card_name,{}))
