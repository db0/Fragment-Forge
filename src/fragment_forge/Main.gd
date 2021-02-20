extends ViewportCardFocus


# Overridable function for games to extend preprocessing of dupe card
# before adding it to the scene
func _extra_dupe_preparation(dupe_focus: Card, card: Card) -> void:
	dupe_focus.printed_properties = card.printed_properties.duplicate()
	for property in card.properties:
		dupe_focus.properties[property] = card.get_property(property)