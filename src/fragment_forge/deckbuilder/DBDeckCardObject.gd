extends DBDeckCardObject


# Updates the Quantity and Influence label
func set_quantity(value) -> void:
	.set_quantity(value)
	

func show_influence(influence) -> void:
	$Influence.text = '(I: ' + str(influence * quantity) + ')'
	
func hide_influence() -> void:
	$Influence.text = ''
	
