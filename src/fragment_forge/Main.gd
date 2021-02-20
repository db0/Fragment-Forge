extends ViewportCardFocus


# Overridable function for games to extend preprocessing of dupe card
# before adding it to the scene
func _extra_dupe_preparation(dupe_focus: Card, card: Card) -> void:
	dupe_focus.printed_properties = card.printed_properties.duplicate()

func _extra_dupe_ready(dupe_focus: Card, card: Card) -> void:
	for property in card.properties:
		dupe_focus.modify_property(property, card.get_property(property), true)
	dupe_focus.card_front.card_labels["Name"].get("custom_fonts/font").size = 8
