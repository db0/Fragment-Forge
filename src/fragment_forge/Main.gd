extends ViewportCardFocus


# Overridable function for games to extend preprocessing of dupe card
# before adding it to the scene
func _extra_dupe_preparation(dupe_focus: Card, card: Card) -> void:
	dupe_focus.printed_properties = card.printed_properties.duplicate()
	var card_illustration = card.get_property("_illustration")
	var illustration_text = "Illustration by: "
	if card.get_property("Type") == CardConfig.CardTypes.SHADER:
		illustration_text = "Fragment Shader by: "
	elif card_illustration == "Artbreeder":
		illustration_text = "Art generated via "
	if card_illustration:
		illustration.text = illustration_text + card_illustration
		illustration.visible = true
	else:
		illustration.visible = false
#func _extra_dupe_ready(dupe_focus: Card, card: Card) -> void:
#	pass
#	for property in card.properties:
#			dupe_focus.modify_property(property, card.get_property(property), true)
