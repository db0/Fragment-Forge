extends ManipulationButtons


func _ready() -> void:
	# The methods to use each of these should be defined in this script
	needed_buttons = {
		"View": "V",
	}
	spawn_manipulation_buttons()


# Hover button which allows the player to view a facedown card
func _on_View_pressed() -> void:
	# warning-ignore:return_value_discarded
	owner_node.set_is_viewed(true)

