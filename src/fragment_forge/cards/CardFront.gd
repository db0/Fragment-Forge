extends CardFront

var value_controls := {}
onready var art := $ArtMargin/CC/Art
onready var noise_texture := $Margin/CardText/OutsideArt


func _ready() -> void:
	text_expansion_multiplier = {
#		"Name": 1,
		"Tags": 1.2,
#		"Time": 3,
#		"Value": 3,
#		"Kudos": 3,
	}
	compensation_label = ""
	_card_text = $Margin/CardText
	card_labels["Name"] = $Margin/CardText/ArtLayover/VBC/Header/HBC/MC/Name
	card_labels["Time"] = $Margin/CardText/ArtLayover/VBC/Header/HBC/TimeC/TimeCC/Time
	card_labels["Kudos"] = $Margin/CardText/ArtLayover/VBC/Header/HBC/KudosC/KudosCC/Kudos
	card_labels["Type"] = $Margin/CardText/ArtLayover/VBC/Type
	card_labels["skill_req"] = $Margin/CardText/ArtLayover/VBC/Requirements/VBC/skill_reqCC/skill_req
	card_labels["cred_req"] = $Margin/CardText/ArtLayover/VBC/Requirements/VBC/cred_reqCC/cred_req
	card_labels["motivation_req"] = $Margin/CardText/ArtLayover/VBC/Requirements/VBC/motivation_reqCC/motivation_req
	card_labels["Abilities"] = $Margin/CardText/OutsideArt/MC/Abilities
	card_labels["Tags"] = $Margin/CardText/ArtLayover/VBC/Tags
	card_labels["Value"] = $Margin/CardText/OutsideArt/ValueContainer/VBC/ValueCC/Value
	value_controls["Value"] = $Margin/CardText/OutsideArt/ValueContainer/VBC/ValueCC
	value_controls["Kudos"] = $Margin/CardText/ArtLayover/VBC/Header/HBC/KudosC
	value_controls["skill_req"] = $Margin/CardText/ArtLayover/VBC/Requirements/VBC/skill_reqCC
	value_controls["cred_req"] = $Margin/CardText/ArtLayover/VBC/Requirements/VBC/cred_reqCC
	value_controls["motivation_req"] = $Margin/CardText/ArtLayover/VBC/Requirements/VBC/motivation_reqCC
	if get_parent().get_parent().get_parent().state != Card.CardState.VIEWPORT_FOCUS:
		var spanel = StyleBoxTexture.new()
		var ntexture = NoiseTexture.new()
		var noise = OpenSimplexNoise.new()
		noise.seed = CFUtils.randi()
		ntexture.noise = noise
		spanel.texture = ntexture
		noise_texture.set("custom_styles/panel", spanel)


func set_label_text(node: Label, value):
	.set_label_text(node, value)
	if not node.visible and node.name in [
		'Kudos',
		'Value',
		'skill_req',
		'cred_req',
		'motivation_req']:
		value_controls[node.name].visible = false
