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
	card_labels["Value"] = $CardText/OutsideArt/ValueContainer/VBC/HBC/ValueCC/Value
	value_controls["Value"] = $CardText/OutsideArt/ValueContainer/VBC/HBC/ValueCC
	value_controls["Kudos"] = $CardText/ArtLayover/Header/HBC/KudosC
	value_controls["skill_req"] = $CardText/ArtLayover/Requirements/VBC/skill_reqCC
	value_controls["cred_req"] = $CardText/ArtLayover/Requirements/VBC/cred_reqCC
	value_controls["motivation_req"] = $CardText/ArtLayover/Requirements/VBC/motivation_reqCC

	card_label_min_sizes["Name"] = Vector2(CFConst.CARD_SIZE.x * 0.66, 19)
	card_label_min_sizes["Kudos"] = Vector2(CFConst.CARD_SIZE.x * 0.12, 19)
	card_label_min_sizes["Time"] = Vector2(CFConst.CARD_SIZE.x * 0.1, 15)
	card_label_min_sizes["Type"] = Vector2(CFConst.CARD_SIZE.x, 16)
	card_label_min_sizes["Tags"] = Vector2(CFConst.CARD_SIZE.x * 0.973, 17)
	card_label_min_sizes["skill_req"] = Vector2(CFConst.CARD_SIZE.x * 0.126, 15)
	card_label_min_sizes["cred_req"] = Vector2(CFConst.CARD_SIZE.x * 0.126, 15)
	card_label_min_sizes["motivation_req"] = Vector2(CFConst.CARD_SIZE.x * 0.126, 15)
	card_label_min_sizes["Abilities"] = Vector2(CFConst.CARD_SIZE.x * 0.8, 88)
	card_label_min_sizes["Value"] = Vector2(CFConst.CARD_SIZE.x * 0.12, 19)

	affinity_icon = $CardText/OutsideArt/ValueContainer/VBC/HBC/AffinityCC/Affinity
	
	for label in card_labels:
		match label:
			"Name":
				original_font_sizes[label] = 12
			"Kudos",\
				"Time",\
				"Type",\
				"skill_req",\
				"cred_req",\
				"motivation_req",\
				"Value":
				original_font_sizes[label] = 10
			"Tags":
				original_font_sizes[label] = 13
			"Abilities":
				original_font_sizes[label] = 13

# We use this as an alternative to scaling the card using the "scale" property.
# This is typically used in the viewport focus only, to keep the text legible
# because scaling the card starts distoring the font.
#
# For gameplay purposes (i.e. scaling on the table etc), we keep using the
# .scale property, as that handles the Area2D size as well.
func scale_to(scale_multiplier: float) -> void:
	for l in card_labels:
		var label : Label = card_labels[l]
		if label.rect_min_size != card_label_min_sizes[l] * scale_multiplier:
			label.rect_min_size = card_label_min_sizes[l] * scale_multiplier
			font_sizes[l] = original_font_sizes.get(l) * scale_multiplier
			$Art.rect_min_size =\
					Vector2(150,150) * scale_multiplier
			$CardText.rect_min_size =\
					Vector2(150,240) * scale_multiplier
			$CardText/ArtLayover.rect_min_size =\
					Vector2(150,150) * scale_multiplier
			$CardText/ArtLayover/Requirements/VBC/skill_reqCC/Icon.rect_min_size =\
					Vector2(15,15) * scale_multiplier
			$CardText/ArtLayover/Requirements/VBC/cred_reqCC/Icon.rect_min_size = \
					Vector2(15,15) * scale_multiplier
			$CardText/ArtLayover/Requirements/VBC/motivation_reqCC/Icon.rect_min_size = \
					Vector2(15,15) * scale_multiplier
			$CardText/ArtLayover/Header/HBC/KudosC/KudosCC/Icon.rect_min_size = \
					Vector2(19,19) * scale_multiplier
			$CardText/ArtLayover/Header/HBC/TimeC/TimeCC/Icon.rect_min_size = \
					Vector2(19,19) * scale_multiplier
			$CardText/OutsideArt/ValueContainer/VBC/HBC/ValueCC/Icon.rect_min_size = \
					Vector2(18,19) * scale_multiplier
			$CardText/OutsideArt/ValueContainer/VBC/HBC/ValueCC/Icon.rect_min_size = \
					Vector2(18,19) * scale_multiplier
			$CardText/OutsideArt/ValueContainer/VBC/HBC/AffinityCC/Affinity.rect_min_size = \
					Vector2(15,15) * scale_multiplier
	for l in card_labels:
		if scaled_fonts.get(l) != scale_multiplier:
			var label : Label = card_labels[l]
			set_label_text(label, label.text)
			scaled_fonts[l] = scale_multiplier
