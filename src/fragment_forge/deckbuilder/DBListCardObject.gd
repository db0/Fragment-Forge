extends DBListCardObject


# This is used to prepare the values of this object
func setup(_card_name: String, count = 0) -> void:
	.setup(_card_name, count)
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

func check_influence() -> void:
	if deck_card_object:
		if deckbuilder.deck_summaries.affinity != card_properties["_affinity"]\
				and card_properties.get("_influence",0) != 0:
			deck_card_object.show_influence(card_properties["_influence"])
		else:
			deck_card_object.hide_influence()
