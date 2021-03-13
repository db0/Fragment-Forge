extends DBDeckCardObject


# Updates the Quantity and Influence label
func set_quantity(value) -> void:
	.set_quantity(value)
	
# Requested when influence used is > 0
func show_influence(influence) -> void:
	$Influence.text = '(I: ' + str(influence * quantity) + ')'

# Requested when card is Neutral or of the same affinity as the persona
func hide_influence() -> void:
	$Influence.text = ''
	
