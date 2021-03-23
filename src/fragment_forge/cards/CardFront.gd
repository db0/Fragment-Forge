extends CardFront

var value_controls := {}
var affinity_icon : TextureRect

func set_label_text(node: Label, value):
	.set_label_text(node, value)
	if not node.visible and node.name in [
		'Kudos',
		'Value',
		'skill_req',
		'cred_req',
		'motivation_req']:
		value_controls[node.name].visible = false
	if not node.visible and node.name == "Kudos":
		card_labels["Name"].rect_min_size.x += node.rect_min_size.x
		set_label_text(card_labels["Name"], card_labels["Name"].text)


func get_card_label_font(_label: Label) -> Font:
	var theme : Theme = self.theme
	var label_font : Font = theme.get_font("font", "Label").duplicate()
	return(label_font)


func set_card_label_font(label: Label, font: Font) -> void:
	label.add_font_override("font", font)
