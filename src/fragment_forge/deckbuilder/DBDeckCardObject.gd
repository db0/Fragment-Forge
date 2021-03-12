extends DBDeckCardObject


# Updates the Quantity and Influence label
func set_quantity(value) -> void:
	.set_quantity(value)
	var card_properties = cfc.card_definitions[card_name]
	$Influence.text = '(I: ' + str(card_properties.get("_influence",0) * value) + ')'
