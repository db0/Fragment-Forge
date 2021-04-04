extends AcceptDialog

enum tutorial_steps {
	WELCOME,
	STEP2,
	TOP_AREA,
	MIDDLE_AREA,
	BOTTOM_AREA,
	START_COMPETITION,
	START_COMPETITION_PLAYER_INPUT,
	START_BUTTON_PRESSED,
}
var current_step : int = tutorial_steps.WELCOME
var board
var board_elements : Dictionary
var proceed_button : Button
var ok_button : Button


func _ready() -> void:
	dialog_hide_on_ok = false
	get_close_button().visible = false
	connect("confirmed", self, "_next_tutorial_step")
	ok_button = get_ok()
	proceed_button = add_cancel("Hide")


func display_tutorial() -> void:
	match current_step:
		tutorial_steps.WELCOME:
			cfc.game_paused = true
			dialog_text = "Welcome to the Fragment Forge Tutorial.\n\n"\
					+ "In this game, you will take the role of an upcoming "\
					+ "demo effects coder and simulate your rise to fame.\n\n"\
					+ "This tutorial will teach you the game basics to allow "\
					+ "you to play the game on your own.\n\n"\
					+ "During this tutorial, you can press OK to proceed to the next "\
					+ "step. Various instruction will require this tutorial to be "\
					+ "closed. If you need to remember the latest instructions "\
					+ "you can simply press the Show Tutorial button on the top."
			_show_popup()
		tutorial_steps.STEP2:
			cfc.game_paused = true
			dialog_text = "This is a fairly simple card game which will challege "\
					+ "your skills at managing your hand of cards "\
					+ "your resources and eventually, your creativity.\n\n"\
					+ "Press OK to proceed."
			_show_popup()
		tutorial_steps.TOP_AREA:
			dialog_text = "Let's take a look through the GUI\n\n"\
					+ "The top area of the game contains details about "\
					+ "your progress in the game, such as counters and statuses "\
					+ "as well as important buttons.\n\n"\
					+ "Press OK to proceed."
			cfc.game_paused = true
			highlight_element([
				"start_button",
				"settings_button",
				"menu_button",
				"counters",
				"competitions",
				"game_goal",
				"persona"])
			_show_popup()
		tutorial_steps.MIDDLE_AREA:
			dialog_text = "The middle area contains the playing board of the game.\n"\
					+ "This is where you'll be playing (installing) your various"\
					+ "cards which stay in play for any period of time.\n\n"\
					+ "Press OK to proceed."
			cfc.game_paused = true
			highlight_element([
				"mc_resources",
				"mc_shaders"])
			_show_popup()
		tutorial_steps.BOTTOM_AREA:
			dialog_text = "The bottom area contains the your deck, hand "\
					+ " and discard pile, You use these to manipulate "\
					+ "your resources and the game state by drawing and playing cards.\n\n"\
					+ "Press OK to proceed."
			cfc.game_paused = true
			highlight_element([
				"deck",
				"hand",
				"discard"])
			_show_popup()
		tutorial_steps.START_COMPETITION:
			dialog_text = "This is the Start Competition Button. "\
					+ "The game will not begin until you press it.\n\n"\
					+ "After you press this button, your will load your starting "\
					+ "hand of 5 cards and receive the resources for the first competition.\n\n"\
					+ "Press OK to hide this window, then go ahead and press it!"
			cfc.game_paused = true
			highlight_element(["start_button"])
			_show_popup()
		tutorial_steps.START_COMPETITION_PLAYER_INPUT:
			cfc.game_paused = true
			board_elements["start_button"].connect("pressed", self, "_next_tutorial_step")
			_hide_popup()
		tutorial_steps.START_BUTTON_PRESSED:
			dialog_text = "Well done, the game has now begun.\n"\
					+ "You will notice that your hand has now filled up with your "\
					+ "5 starting cards and that your counters will have populated.\n\n"\
					+ "We're now going to go through each individual element to explain what they are.\n\n"\
					+ "Press OK to proceed."
			cfc.game_paused = true
			board_elements["start_button"].disconnect("pressed", self, "_next_tutorial_step")
			_show_popup()

func highlight_element(elements: Array) -> void:
	var board_tween: Tween = board.get_node("BoardTween")
	for belement in board_elements:
		if belement in elements or elements == ['all']:
			board_tween.interpolate_property(board_elements[belement],'modulate',
					board_elements[belement].modulate, Color(1,1,1), 0.75,
					Tween.TRANS_SINE, Tween.EASE_OUT)
		else:
			board_tween.interpolate_property(board_elements[belement],'modulate',
					board_elements[belement].modulate, Color(0.25,0.25,0.25), 0.75,
					Tween.TRANS_SINE, Tween.EASE_OUT)
		board_tween.start()

func _next_tutorial_step() -> void:
	current_step += 1
	display_tutorial()

func _show_popup() -> void:
	rect_size.y = 0
	popup_centered_minsize()
	board.show_tutorial.visible = false
	proceed_button.visible = false
	ok_button.visible = true

func _hide_popup() -> void:
	highlight_element(["all"])
	hide()
	proceed_button.visible = true
	ok_button.visible = false


func _on_Tutorial_about_to_show() -> void:
	board.show_tutorial.visible = false


func _on_Tutorial_popup_hide() -> void:
	board.show_tutorial.visible = true
