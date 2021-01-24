extends CardFront

onready var art = $Margin/CardText/Art

func _ready() -> void:
	text_expansion_multiplier = {
		"Name": 2,
		"Tags": 1.2,
		"Cost": 3,
		"Power": 3,
	}
	compensation_label = "Abilities"
	_card_text = $Margin/CardText
	card_labels["Name"] = $Margin/CardText/Name
	card_labels["Type"] = $Margin/CardText/Type
	card_labels["Tags"] = $Margin/CardText/Tags
	card_labels["Abilities"] = $Margin/CardText/Abilities
	card_labels["Time"] = $Margin/CardText/HBC/Time
	card_labels["Value"] = $Margin/CardText/HBC/Value
	card_labels["Kudos"] = $Margin/CardText/HBC/Kudos
	card_labels["skill_req"] = $Margin/CardText/skill_req
	card_labels["cred_req"] = $Margin/CardText/cred_req
	card_labels["motivation_req"] = $Margin/CardText/motivation_req
