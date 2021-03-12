class_name DBFilterIconButton
extends Control


signal filter_toggled()

var pressed := true
var property : String
var value: String


func _ready() -> void:
	pass


func setup(_property: String, _value: String) -> void:
	property = _property
	value = _value
	name = _value
	var icon_texture = ImageTexture.new();
	var image =  CardConfig.Affinities[_value].icon.get_data()
	icon_texture.create_from_image(image)
	$Icon.texture = icon_texture
	$HoverDescription/Label.text = CardConfig.Affinities[_value]["name"]


func _on_Button_pressed() -> void:
	pressed = !pressed
	emit_signal("filter_toggled")



func _on_Button_mouse_entered() -> void:
	$HoverDescription.rect_global_position.y =\
			self.rect_global_position.y - $HoverDescription.rect_size.y - 10
	$HoverDescription.rect_global_position.x =\
			self.rect_global_position.x + self.rect_size.x / 2 - $HoverDescription/Label.rect_size.x / 2
	$HoverDescription.visible = true


func _on_Button_mouse_exited() -> void:
	$HoverDescription.visible = false
