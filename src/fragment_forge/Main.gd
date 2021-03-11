extends ViewportCardFocus


# Overridable function for games to extend preprocessing of dupe card
# before adding it to the scene
func _extra_dupe_preparation(dupe_focus: Card, card: Card) -> void:
	dupe_focus.printed_properties = card.printed_properties.duplicate()
	cfc.ov_utils.populate_info_panels(card,focus_info)
#func _extra_dupe_ready(dupe_focus: Card, card: Card) -> void:
#	pass
#	for property in card.properties:
#			dupe_focus.modify_property(property, card.get_property(property), true)
