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
