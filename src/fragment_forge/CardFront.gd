extends CardFront

onready var art := $ArtMargin/CC/Art
onready var noise_texture := $Margin/CardText/OutsideArt

func _ready() -> void:
	text_expansion_multiplier = {
		"Name": 2,
		"Tags": 1.2,
		"Cost": 3,
		"Power": 3,
	}
	compensation_label = ""
	_card_text = $Margin/CardText
	card_labels["Name"] = $Margin/CardText/ArtLayover/VBC/Name
	card_labels["Type"] = $Margin/CardText/ArtLayover/VBC/Type
	card_labels["Tags"] = $Margin/CardText/ArtLayover/VBC/Tags
	card_labels["skill_req"] = $Margin/CardText/ArtLayover/VBC/skill_req
	card_labels["cred_req"] = $Margin/CardText/ArtLayover/VBC/cred_req
	card_labels["motivation_req"] = $Margin/CardText/ArtLayover/VBC/motivation_req
	card_labels["Abilities"] = $Margin/CardText/OutsideArt/VBC/MC/Abilities
	card_labels["Time"] = $Margin/CardText/OutsideArt/VBC/HBC/Time
	card_labels["Value"] = $Margin/CardText/OutsideArt/VBC/HBC/Value
	card_labels["Kudos"] = $Margin/CardText/OutsideArt/VBC/HBC/Kudos
	var sb = noise_texture.get("custom_styles/panel")
	sb.texture.noise.seed = CFUtils.randi()

