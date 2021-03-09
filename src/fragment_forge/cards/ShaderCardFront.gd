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

	card_label_min_sizes["Name"] = Vector2(CFConst.CARD_SIZE.x * 0.66, 19)
	card_label_min_sizes["Kudos"] = Vector2(CFConst.CARD_SIZE.x * 0.12, 19)
	card_label_min_sizes["Time"] = Vector2(CFConst.CARD_SIZE.x * 0.1, 15)
	card_label_min_sizes["Type"] = Vector2(CFConst.CARD_SIZE.x, 13)
	card_label_min_sizes["Tags"] = Vector2(CFConst.CARD_SIZE.x * 0.73, 13)
	card_label_min_sizes["skill_req"] = Vector2(CFConst.CARD_SIZE.x * 0.126, 15)
	card_label_min_sizes["cred_req"] = Vector2(CFConst.CARD_SIZE.x * 0.126, 15)
	card_label_min_sizes["motivation_req"] = Vector2(CFConst.CARD_SIZE.x * 0.126, 15)
	card_label_min_sizes["Abilities"] = Vector2(CFConst.CARD_SIZE.x * 0.953, 100)
	card_label_min_sizes["Value"] = Vector2(CFConst.CARD_SIZE.x * 0.12, 19)

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
				original_font_sizes[label] = 20

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
			$Margin/CardText/Requirements/VBC/skill_reqCC/Icon.rect_min_size =\
					Vector2(15,15) * scale_multiplier
			$Margin/CardText/Requirements/VBC/cred_reqCC/Icon.rect_min_size = \
					Vector2(15,15) * scale_multiplier
			$Margin/CardText/Requirements/VBC/motivation_reqCC/Icon.rect_min_size = \
					Vector2(15,15) * scale_multiplier
			$Margin/CardText/Header/HBC/KudosC/KudosCC/Icon.rect_min_size = \
					Vector2(19,19) * scale_multiplier
			$Margin/CardText/Header/HBC/TimeC/TimeCC/Icon.rect_min_size = \
					Vector2(19,19) * scale_multiplier
			$Margin/ValueContainer/VBC/ValueCC/Icon.rect_min_size = \
					Vector2(18,19) * scale_multiplier
	for l in card_labels:
		if scaled_fonts.get(l) != scale_multiplier:
			var label : Label = card_labels[l]
			set_label_text(label, label.text)
			scaled_fonts[l] = scale_multiplier
