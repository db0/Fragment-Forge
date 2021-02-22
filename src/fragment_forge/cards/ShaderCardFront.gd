extends "res://src/fragment_forge/cards/CardFront.gd"

onready var art = $ArtLayout/ArtMargin/CC/Art
onready var art_layout = $ArtLayout

func _ready() -> void:
	text_expansion_multiplier = {
		"Tags": 1.2,		
	}
	compensation_label = "Abilities"
	_card_text = $Margin/CardText
	card_labels["Name"] = $Margin/CardText/Header/HBC/Name
	card_labels["Time"] = $Margin/CardText/Header/HBC/TimeC/TimeCC/Time
	card_labels["Kudos"] = $Margin/CardText/Header/HBC/KudosC/KudosCC/Kudos
	card_labels["Type"] = $Margin/CardText/Type
	card_labels["Tags"] = $Margin/CardText/Requirements/VBoxContainer/Tags
	card_labels["skill_req"] = $Margin/CardText/Requirements/VBC/skill_reqCC/skill_req
	card_labels["cred_req"] = $Margin/CardText/Requirements/VBC/cred_reqCC/cred_req
	card_labels["motivation_req"] = $Margin/CardText/Requirements/VBC/motivation_reqCC/motivation_req
	card_labels["Abilities"] = $Margin/CardText/Abilities
	card_labels["Value"] = $Margin/ValueContainer/VBC/ValueCC/Value
	value_controls["Kudos"] = $Margin/CardText/Header/HBC/KudosC
	value_controls["skill_req"] = $Margin/CardText/Requirements/VBC/skill_reqCC
	value_controls["cred_req"] = $Margin/CardText/Requirements/VBC/cred_reqCC
	value_controls["motivation_req"] = $Margin/CardText/Requirements/VBC/motivation_reqCC
	value_controls["Value"] = $Margin/ValueContainer
