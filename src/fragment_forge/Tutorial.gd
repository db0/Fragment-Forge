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
	START_BUTTON,
	PERSONA,
	GAME_GOAL,
	COMPETITIONS,
	COMPETITIONS_CONT,
	COUNTERS,
	HAND,
	SHADERS,
	SHADERS_CONT,
	SHADERS_PLAYER_INPUT,
	SHADERS_PLAYED,
}

const TUTORIALS := {
	tutorial_steps.WELCOME: "Welcome to the Fragment Forge Tutorial.\n\n"\
	+ "In this game, you will take the role of an upcoming "\
	+ "demo effects coder and simulate your rise to fame.\n\n"\
	+ "This tutorial will teach you the game basics to allow "\
	+ "you to play the game on your own.\n\n"\
	+ "During this tutorial, you can press OK to proceed to the next "\
	+ "step. Various instruction will require this tutorial to be "\
	+ "closed. If you need to remember the latest instructions "\
	+ "you can simply press the Show Tutorial button on the top.",
	tutorial_steps.STEP2: "This is a card game which will challege "\
	+ "your skills at managing your hand of cards "\
	+ "your resources and eventually, your creativity.\n\n"\
	+ "Your main goal is very simple. You need to accumulate "\
	+ "enough 'cred' (as in 'credibility') over a series of rounds, "\
	+ "and playing cards from your hand is your main way to do so.\n\n"\
	+ "You main objective is to play enough cards and in the right "\
	+ "combinations, to place well in each of the three rounds "\
	+ "and therefore gather enough cred to win the game before the last "\
	+ "round ends.\n\n"\
	+ "Press OK to proceed.",
	tutorial_steps.TOP_AREA: "Let's take a look through the GUI\n\n"\
	+ "The top area of the game contains details about "\
	+ "your progress in the game, such as counters and statuses "\
	+ "as well as important buttons.\n\n"\
	+ "Press OK to proceed.",
	tutorial_steps.MIDDLE_AREA: "The middle area contains the playing board of the game.\n"\
	+ "This is where you'll be playing (installing) your various"\
	+ "cards which stay in play for any period of time.\n\n"\
	+ "Press OK to proceed.",
	tutorial_steps.BOTTOM_AREA:  "The bottom area contains the your deck, hand "\
	+ " and discard pile, You use these to manipulate "\
	+ "your resources and the game state by drawing and playing cards.\n\n"\
	+ "Press OK to proceed.",
	tutorial_steps.START_COMPETITION: "This is the Start Competition Button. "\
	+ "The game will not begin until you press it.\n\n"\
	+ "After you press this button, your will load your starting "\
	+ "hand of 5 cards and receive the resources for the first competition.\n\n"\
	+ "Press OK to hide this window, then go ahead and press it!",
	tutorial_steps.START_COMPETITION_PLAYER_INPUT: '',
	tutorial_steps.START_BUTTON_PRESSED: "Great, the game has now begun.\n"\
	+ "You will notice that your hand has now filled up with your "\
	+ "5 starting cards and that your counters will have populated.\n\n"\
	+ "We're now going to go through each individual element to explain what they are.\n\n"\
	+ "Press OK to proceed.",
	tutorial_steps.START_BUTTON: "First of all, you'll notice that the Start Button "\
	+ "has now become the 'Next Competition' button.\n"\
	+ "Each Fragment Forge game runs over 3 rounds or competitions.\n"\
	+ "Each competition provides an amount of 'time' which you can "\
	+ "use to play your cards. When your time runs out, you typically "\
	+ "can do nothing else, except end the current competition.\n"\
	+ "You do so via this button, which will initiate the next "\
	+ "competition, or end the game if this was the last one.\n\n"\
	+ "Press OK to proceed.",
	tutorial_steps.PERSONA: "This is your current persona.\n"\
	+ "Along with an illustration, it contains the name of this character "\
	+ "as well as their ability they provide to you.\n\n"\
	+ "You will notice the picture resides on top of a button.\n"\
	+ "This is because each persona has a unique ability which often you activate on-demand.\n"\
	+ "When you want to do so, you simply click on this button.\n"\
	+ "If the button is deactivated, it means the persona's ability has already "\
	+ "been used. It will reactivate automatically, according to the persona's ability.\n\n"\
	+ "Press OK to proceed.",
	tutorial_steps.GAME_GOAL: "This area shows the general state of the game.\n\n"\
	+ "The first field shows the current cred you need to achieve to win this game."\
	+ "This is based on the selected difficulty.\n\n"\
	+ "Below that is the current comptition and the total amount you will play this game.\n\n"\
	+ "Finally the current difficulty level is shown.\n\n"\
	+ "Press OK to proceed.",
	tutorial_steps.COMPETITIONS: "This is the current competition details and "\
	+ "it starts with the name of the current competition.\n\nMany competitions will include "\
	+ "modifiers to the standard gameplay, and whenever this is the casse, they "\
	+ "will be displayed in the yellow text.\n\n"\
	+ "At the bottom, you see the value of your current demo.\n"\
	+ "Your demo value is a combination of all the cards that you have installed "\
	+ "Which are providing any value. These are primarily Shaders, but there's "\
	+ "other cards which can help. The higher your demo value, the higher you "\
	+ "get to place in the current competition.\n"\
	+ "Next to those, currently in red, you will see the placement requirements.\n"\
	+ "Once a placement's value threshold is reached, it will turn green, "\
	+ "which will signify that you will receive the corresponding cred reward "\
	+ "after this competition is concluded.  (i.e. once you press 'Next Competition').\n\n"\
	+ "Press OK to proceed.",
	tutorial_steps.COMPETITIONS_CONT: "Obviously getting the highest position "\
	+ "in each competition is the best scenario, but that is easier said than done.\n\n"\
	+ "However there's an extra benefit whenever you achieve first place: "\
	+ "You also receive +1 motivation, which might help play more powerful cards "\
	+ "and provide chear card draw.\n"\
	+ "Likewise, there's also a penaly whenever you fail to achieve any placement"\
	+ "in a competition: You lose 2 motivation.\n\n"\
	+ "Therefore you need to balance the detriments of completely ignoring a "\
	+ "competition in favour of placing better in the next one.\n\n"\
	+ "Press OK to proceed.",
	tutorial_steps.COUNTERS: "The last of the top areas is the resource counters information.\n\n"\
	+ "There's 5 main resources you need to keep an eye on during the game:\n"\
	+ "* Time: This shows the amount of time you have in this competition. "\
	+ "Since almost anything you do requires time, this is the most valuable resource "\
	+ "you have. Once your time runs out, there's usually little else to do "\
	+ "than proceed to the next competition\n"\
	+ "* Skill: How good you have become at coding Fragment Shaders. "\
	+ "the higher your skill is, the more poweful shaders you can play cheaply."\
	+ "You automatically receive +1 skill after each competition ends.\n"\
	+ "* Cred: How close you are to winning the game. Once you have enough cred to "\
	+ "win the game, the game will automatically end. There are also various cards "\
	+ "which might require a level of cred to allow you to play them.\n"\
	+ "* Kudos: A somewhat optional response which signifies how much you've supported "\
	+ "the demoscene economy. Most non-Shader cards require Kudos to play.\n"\
	+ "* Motivation: This resource signifies your drive to take part in competitions. "\
	+ "There's two mechanical aspects to competition. First of all, each card you "\
	+ "try to draw to your hand over your motivation, costs more time. "\
	+ "Secondly, if you ever drop to 0 motivation, you lose the game!\n\n"\
	+ "Press OK to proceed.",
	tutorial_steps.HAND: "Now let's take a look at your hand "\
	+ "and the card types you will encounter.\n\n"\
	+ "As you can see, your starting hand-size is 5. But you also have a maximum "\
	+ "hand size of 10. You can never hold more than 10 cards in your hand. "\
	+ "(further card draws will be ignored)\n\n"\
	+ "You can mouse over any card in your hand to see a larger version of it."\
	+ "The card highlight will also signify if you can play the card:\n"\
	+ "* White: The card can be played using its printed cost.\n"\
	+ "* Green: The card can be played using a discounted cost.\n"\
	+ "* Yellow: The card can be played using an increased cost.\n"\
	+ "* Red: The card cannot be played.\n"\
	+ "As you mouse over a card, you will also notice that it will display "\
	+ "details about its cost. Those will also show any card effects modifying. "\
	+ "its cost in any direction.\n\n"\
	+ "Press OK to proceed.",
	tutorial_steps.SHADERS: "The first and most important card type you'll encounter "\
	+ "is a Shader AKA 'Fragment Shader'. These are the bread and butter of each deck.\n"\
	+ "You use shaders to increase your demo value. The more difficult the shader"\
	+ "the more value it tends to add, or the more powerful abilities it might provide.\n\n"\
	+ "Shaders cards have various fields.\n"\
	+ "* Name: Shown on the top left.\n"\
	+ "* Costs: Kudos and Time costs are shown on the top right.\n"\
	+ "* Requirements: If the Shader has any skill, cred or motivation requirements. "\
	+ "they will be shown on the middle left area, overlapping the shader effect illustration.\n"\
	+ "* Type: This will always be 'Shader' and will be just below the title.\n"\
	+ "* Tags: Any tags will be shown in the middle right. Next to any requirements\n"\
	+ "* Abilities: Many Shaders will provide various positive or negative abilities. "\
	+ "When they exist, they will be shown in the middle of the card, over its illustration.\n"\
	+ "* Value: The amount of value the Shader adds to your demo will be shown "\
	+ "* Value: on the bottom right of the card"\
	+ "* Illustration: Shaders all have endlessly playing animations which is displayed"\
	+ "on the back of the card.\n\n"\
	+ "Press OK to proceed.",
	tutorial_steps.SHADERS_CONT: "You can play cards from your hand by either "\
	+ "double-clicking them or by drag & dropping them to the board.\n"\
	+ "Each shader costs time to play. The amount if shown under the time cost "\
	+ "on the top (clock icon).\n"\
	+ "* For Shaders of equal skill requirement as your skill, you pay the exact "\
	+ "time cost shown on their cost."\
	+ "* For Shaders of 1 skill requirement higher than your skill, you pay an extra "\
	+ "time cost equal to their skill requirement + 50% of their time cost on top\n"\
	+ "* For Shaders of lower skill requirement your skill, you pay 1 less time "\
	+ "for each skill you have higher than their requirements, up to a maximum of half-cost.\n"\
	+ "* Shader of 2 or higher skill requirement than your skill cannot be played.\n\n"\
	+ "Let's try to play a shader now. Try to play the Twister Shader from your hand.\n\n"\
	+ "Press OK to hide this window. Then play the Twister shader by either "\
	+ "double-clicking on it or by drag & dropping it to the board",
	tutorial_steps.SHADERS_PLAYER_INPUT: '',
	tutorial_steps.SHADERS_PLAYED: "Well Done! If you double-clicked the card "\
	+ "or drag & dropped it to a random location, notice how it autoplaces itself"\
	+ "to the Shaders area on the board.\n\n"\
	+ "Press OK to proceed.",
}

const HIGHLIGHTS = {
	tutorial_steps.WELCOME: ['all'],
	tutorial_steps.STEP2:  ['all'],
	tutorial_steps.TOP_AREA: [
			"start_button",
			"settings_button",
			"menu_button",
			"counters",
			"competitions",
			"game_goal",
			"persona"],
	tutorial_steps.MIDDLE_AREA: [
			"mc_resources",
			"mc_shaders"],
	tutorial_steps.BOTTOM_AREA: [
			"deck",
			"hand",
			"discard"],
	tutorial_steps.START_COMPETITION: ["start_button"],
	tutorial_steps.START_COMPETITION_PLAYER_INPUT: ['all'],
	tutorial_steps.START_BUTTON_PRESSED: ['all'],
	tutorial_steps.START_BUTTON: ["start_button"],
	tutorial_steps.PERSONA: ["persona"],
	tutorial_steps.GAME_GOAL: ["game_goal"],
	tutorial_steps.COMPETITIONS: ["competitions"],
	tutorial_steps.COMPETITIONS_CONT: ["competitions"],
	tutorial_steps.COUNTERS: ["counters"],
	tutorial_steps.HAND: ["hand"],
	tutorial_steps.SHADERS: ["hand"],
	tutorial_steps.SHADERS_CONT: ["hand"],
	tutorial_steps.SHADERS_PLAYER_INPUT: ["all"],
	tutorial_steps.SHADERS_PLAYED: ["mc_shaders","competitions"],
}

var current_step : int = tutorial_steps.WELCOME
var board
var board_elements : Dictionary
var proceed_button : Button
var ok_button : Button
var current_card: Card

func _ready() -> void:
	dialog_hide_on_ok = false
	get_close_button().visible = false
	connect("confirmed", self, "_next_tutorial_step")
	ok_button = get_ok()
	proceed_button = add_cancel("Hide")


func display_tutorial() -> void:
	match current_step:
		tutorial_steps.START_COMPETITION_PLAYER_INPUT:
			cfc.game_paused = true
			board_elements["start_button"].connect("pressed", self, "_next_tutorial_step")
			_hide_popup()
		tutorial_steps.START_BUTTON_PRESSED:
			dialog_text = TUTORIALS[current_step]
			cfc.game_paused = true
			board_elements["start_button"].disconnect("pressed", self, "_next_tutorial_step")
			_show_popup()
		tutorial_steps.SHADERS:
			dialog_text = TUTORIALS[current_step]
			cfc.game_paused = true
			current_card = cfc.NMAP.hand.get_card(0)
			current_card._on_Card_mouse_entered()
			_show_popup()
		tutorial_steps.SHADERS_CONT:
			dialog_text = TUTORIALS[current_step]
			cfc.game_paused = true
			current_card = cfc.NMAP.hand.get_card(0)
			current_card._on_Card_mouse_exited()
			_show_popup()
		tutorial_steps.SHADERS_PLAYER_INPUT:
			cfc.game_paused = false
			current_card = cfc.NMAP.hand.get_card(1)
			current_card.connect("card_moved_to_board", self, "_on_card_trigger")
			for card in cfc.NMAP.hand.get_all_cards():
				if card != current_card:
					card.disable_dragging_from_hand = true
					card.tutorial_disabled = true
			_hide_popup()
		tutorial_steps.SHADERS_PLAYED:
			cfc.game_paused = true
			current_card.disconnect("card_moved_to_board", self, "_on_card_trigger")
			dialog_text = TUTORIALS[current_step]
			_show_popup()
		# This is the standard tutorial step with a potential highlight
		_:
			cfc.game_paused = true
			dialog_text = TUTORIALS[current_step]
			highlight_element(HIGHLIGHTS[current_step])
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

func _on_card_trigger(_card,_trigger,_details) -> void:
	_next_tutorial_step()
