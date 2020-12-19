extends Card

func _init_front_labels() -> void:
# Maps the location of the card front labels so that they're findable even when
# The card front is customized for games of different needs
	._init_front_labels()
	_card_labels["Name"] = $Control/Front/Margin/CardText/Name
	_card_labels["Type"] = $Control/Front/Margin/CardText/Type
	_card_labels["Tags"] = $Control/Front/Margin/CardText/Tags
	_card_labels["Requirements"] = $Control/Front/Margin/CardText/Requirements
	_card_labels["Abilities"] = $Control/Front/Margin/CardText/Abilities
	_card_labels["Cost"] = $Control/Front/Margin/CardText/HB/Cost
	print(_card_labels["Power"])
