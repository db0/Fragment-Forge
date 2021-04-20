extends DBListCardObject


# This is used to prepare the values of this object
func setup(_card_name: String, count = 0, init_card_object = false) -> void:
	.setup(_card_name, count, init_card_object)
	$Influence.text = str(card_properties.get("_influence",0))
	var affinity = card_properties.get("_affinity")
	var icon_texture = ImageTexture.new();
	var image =  CardConfig.Affinities[affinity].icon.get_data()
	icon_texture.create_from_image(image)
	$Affinity.texture = icon_texture

# Setter for quantity
#
# Will also set the correct button as pressed when the quantity is changed
# elsewhere.
func set_quantity(value) -> void:
	.set_quantity(value)
	check_influence()


# Checks if the linked DBDeckCardObject needs to display taken influence
# next to its name
func check_influence() -> void:
	if deck_card_object:
		if deckbuilder.deck_summaries.affinity != card_properties["_affinity"]:
			var current_quantity : int = deck_card_object.quantity
			if  deckbuilder.deck_summaries.persona\
					and deckbuilder.deck_summaries.persona.persona_name == "Fractal Thoughts"\
					and card_properties.Type == CardConfig.CardTypes.SHADER:
				current_quantity -= 1
			if card_properties.get("_influence",0) * current_quantity != 0:
				deck_card_object.show_influence(
							card_properties.get("_influence",0)
							* current_quantity)
			else:
				deck_card_object.hide_influence()
		else:
			deck_card_object.hide_influence()
