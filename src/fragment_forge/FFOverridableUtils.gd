extends OVUtils


# Populates the info panels under the card, when it is shown in the
# viewport focus or deckbuilder
func populate_info_panels(card: Card, focus_info: Node) -> void:
	var card_illustration = card.get_property("_illustration")
	var illustration_text = "Illustration by: "
	if card.get_property("Type") == CardConfig.CardTypes.SHADER:
		illustration_text = "Fragment Shader by: "
	elif card_illustration == "Artbreeder":
		illustration_text = "Art generated via "
	if card_illustration:
		focus_info.show_illustration(illustration_text + card_illustration)
	else:
		focus_info.hide_illustration()
	for tag in card.get_property("Tags"):
		if CardConfig.EXPLANATIONS.has(tag):
			if tag in CardConfig.ACTIVE_TAGS:
				focus_info.add_info(tag, CardConfig.EXPLANATIONS[tag], preload("res://src/fragment_forge/InfoActivePanel.tscn"))
			else:
				focus_info.add_info(tag, CardConfig.EXPLANATIONS[tag])
	var card_keywords = card.get_property("_keywords")
	if card_keywords:
		for keyword in card_keywords:
			if CardConfig.EXPLANATIONS.has(keyword):
				focus_info.add_info(keyword, CardConfig.EXPLANATIONS[keyword])		
