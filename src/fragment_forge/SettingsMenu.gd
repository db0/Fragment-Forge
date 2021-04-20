extends CenterContainer

onready var back_button = $PC/VBC/HBoxContainer/Back
onready var animate_in_hand = $PC/VBC/AnimateHand
onready var animate_on_board = $PC/VBC/AnimateBoard
onready var fancy_movement = $PC/VBC/FancyMovement
onready var recover_prebuilts = $PC/VBC/PreBuilts

func _ready() -> void:
	cfc.game_settings['animate_in_hand'] = cfc.game_settings.get('animate_in_hand', false)
	cfc.game_settings['animate_on_board'] = cfc.game_settings.get('animate_on_board', false)
	cfc.game_settings['fancy_movement'] = cfc.game_settings.get('fancy_movement', CFConst.FANCY_MOVEMENT)
	animate_in_hand.pressed = cfc.game_settings.animate_in_hand
	animate_on_board.pressed = cfc.game_settings.animate_on_board
	fancy_movement.pressed = cfc.game_settings.fancy_movement

func _on_AnimateBoard_toggled(button_pressed: bool) -> void:
	cfc.set_setting('animate_on_board',button_pressed)


func _on_AnimateHand_toggled(button_pressed: bool) -> void:
	cfc.set_setting('animate_in_hand',button_pressed)


func _on_FancyMovement_toggled(button_pressed: bool) -> void:
	cfc.set_setting('fancy_movement',button_pressed)
