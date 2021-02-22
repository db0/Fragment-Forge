extends "res://src/fragment_forge/cards/CardFront.gd"

onready var art := $Art
onready var noise_texture := $CardText/OutsideArt

func _ready() -> void:
	text_expansion_multiplier = {
		"Tags": 1.2,
	}
	_card_text = $CardText
	card_labels["Name"] = $CardText/ArtLayover/Header/HBC/Name
	card_labels["Time"] = $CardText/ArtLayover/Header/HBC/TimeC/TimeCC/Time
	card_labels["Kudos"] = $CardText/ArtLayover/Header/HBC/KudosC/KudosCC/Kudos
	card_labels["Type"] = $CardText/ArtLayover/Type
	card_labels["skill_req"] = $CardText/ArtLayover/Requirements/VBC/skill_reqCC/skill_req
	card_labels["cred_req"] = $CardText/ArtLayover/Requirements/VBC/cred_reqCC/cred_req
	card_labels["motivation_req"] = $CardText/ArtLayover/Requirements/VBC/motivation_reqCC/motivation_req
	card_labels["Abilities"] = $CardText/OutsideArt/Abilities
	card_labels["Tags"] = $CardText/ArtLayover/Tags
	card_labels["Value"] = $CardText/OutsideArt/ValueContainer/VBC/ValueCC/Value
	value_controls["Value"] = $CardText/OutsideArt/ValueContainer/VBC/ValueCC
	value_controls["Kudos"] = $CardText/ArtLayover/Header/HBC/KudosC
	value_controls["skill_req"] = $CardText/ArtLayover/Requirements/VBC/skill_reqCC
	value_controls["cred_req"] = $CardText/ArtLayover/Requirements/VBC/cred_reqCC
	value_controls["motivation_req"] = $CardText/ArtLayover/Requirements/VBC/motivation_reqCC
