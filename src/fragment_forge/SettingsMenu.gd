extends CenterContainer

onready var back_button = $PC/VBC/HBoxContainer/Back
onready var animate_in_hand = $PC/VBC/AnimateHand
onready var animate_on_board = $PC/VBC/AnimateBoard

func _ready() -> void:
	animate_in_hand.pressed = cfc.game_settings.animate_in_hand
	animate_on_board.pressed = cfc.game_settings.animate_on_board


func _on_AnimateHand_pressed() -> void:
	cfc.set_setting('animate_in_hand',animate_in_hand.pressed)


func _on_AnimateBoard_pressed() -> void:
	cfc.set_setting('animate_on_board',animate_on_board.pressed)
