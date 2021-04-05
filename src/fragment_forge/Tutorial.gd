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
	RESOURCES,
	RESOURCES_CONT,
	RESOURCES_PLAYER_INPUT,
	RESOURCES_PLAYED,
	RESOURCES_USE_PLAYER_INPUT,
	RESOURCES_USED,
	PREP,
	PREP_CONT,
	PREP_PLAYER_INPUT,
	PREP_PLAYED,
	CARD_DRAW,
	TUTORS,
	TUTOR_PLAYER_INPUT,
	TUTOR_PLAYED,
	FREE_PLAY,
	NEXT_COMPETITION,
	END,
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
	+ "on the bottom right of the card"\
	+ "* Affinity: The affinity of the current Shader, if any, will be shown next "\
	+ "to the value, on the bottom right of the card. It has no mechanical impact on the game."\
	+ "* Illustration: Shaders all have endlessly playing animations which is displayed"\
	+ "of the background of the card.\n\n"\
	+ "Press OK to proceed.",
	tutorial_steps.SHADERS_CONT: "You can play cards from your hand by either "\
	+ "double-clicking them or by drag & dropping them to the board.\n"\
	+ "Each shader costs time to play. The amount if shown under the time cost "\
	+ "on the top (clock icon).\n"\
	+ "* For Shaders of equal skill requirement as your skill, you pay the exact "\
	+ "time cost shown on their cost.\n"\
	+ "* For Shaders of 1 skill requirement higher than your skill, you pay an extra "\
	+ "time cost equal to their skill requirement + 50% of their time cost on top\n"\
	+ "* For Shaders of lower skill requirement your skill, you pay 1 less time "\
	+ "for each skill you have higher than their requirements, up to a maximum of half-cost.\n"\
	+ "* Shader of 2 or higher skill requirement than your skill cannot be played.\n\n"\
	+ "Finally, one last important thing to remember about Shaders is that they only "\
	+ "last until the end of the current competition and will be discarded immediately after!\n\n"\
	+ "Let's try to play a shader now. Try to play the Twister Shader from your hand.\n\n"\
	+ "Press OK to hide this window. Then play the Twister shader by either "\
	+ "double-clicking on it or by drag & dropping it to the board",
	tutorial_steps.SHADERS_PLAYER_INPUT: '',
	tutorial_steps.SHADERS_PLAYED: "Well Done! If you double-clicked the card "\
	+ "or drag & dropped it to a random location, notice how it autoplaces itself"\
	+ "to the Shaders area on the board.\n\n"\
	+ "You will notice that your demo value has now increased by the Shader's value (5) "\
	+ "and that your available time has also decreased by its time cost (5). "\
	+ "You are well on your way to achieving some recognition for your shader coding skills.\n\n"\
	+ "Press OK to proceed.",
	tutorial_steps.RESOURCES: "The second type of card available are resources.\n"\
	+ "These represent friends & acquaitances, knowledge or even temporary volunteering gigs "\
	+ "you take as part of being in the demoscene community.\n\n"\
	+ "Resources tend to require less time to install than Shaders, but instead they tend "\
	+ "to cost Kudos to play, or have cred, motivation or skill requirements.\n"\
	+ "On Resource cards you will notice the following fields:\n"\
	+ "* Name: Shown on the top left.\n"\
	+ "* Costs: Kudos and Time costs are shown on the top right.\n"\
	+ "* Requirements: If the Resource has any skill, cred or motivation requirements. "\
	+ "they will be shown on the middle left area, overlapping the card illustration.\n"\
	+ "* Type: This will always be 'Resource' and will be just below the title.\n"\
	+ "* Tags: Any tags will be shown at the bottom of the illustration.\n"\
	+ "* Abilities: All resources have a positive abilities (i.e. a reason to play them), "\
	+ "but some of them might also come with an extra cost or requirement in their use. "\
	+ "These will be explained in the main ability text.\n"\
	+ "* Affinity: The affinity of the resource, if any, will be shown "\
	+ "on the bottom right of the card. It has no mechanical impact on the game.\n"\
	+ "* Illustration: Resources have static art, which is displayed in the top middle "\
	+ "of the background of the card.\n\n"\
	+ "Press OK to proceed.",
	tutorial_steps.RESOURCES_CONT: "Playing a resource is the same as playing a Shader,"\
	+ "You need to ensure you have enough Time and Kudos and that you match all  "\
	+ "requirements. If you don't, the card will be highlighted red.\n"\
	+ "Unlike Shaders, Resource time cost is not affected by your current skill level.\n\n"\
	+ "Press OK to hide this window. Then play the 'Discord mod' resource by either "\
	+ "double-clicking on it or by drag & dropping it to the board. This card doesn't "\
	+ "give any value but will provide necessary Kudos to play future resources.",
	tutorial_steps.RESOURCES_PLAYER_INPUT: '',
	tutorial_steps.RESOURCES_PLAYED: "The Resource is now installed but you will "\
	+ "notice you didn't actually receive any Kudos. If you read the text of the card "\
	+ "you will notice that it doesn't give you Kudos when played, but will rather "\
	+ "provide Kudos on demand.\n\n"\
	+ "To use an installed resource with an ad-hoc ability, simply double-click on it.\n"\
	+ "If you fulfil its requirements it will activate its effect.\n\n"\
	+ "Installed card effects tend to either require you to expend some resource "\
	+ "such as Time, Kudos or a Token on the card, or they will require you "\
	+ "'Exhaust' the card. Exhausting means the card is turned 90 degrees sideways "\
	+ "and cannot be re-used this competition. It will automatically unexhaust "\
	+ "at the start of the next competition.\n\n"\
	+ "The order of effects on a card is in the form of 'Cost: Effect'. "\
	+ "This means that everything behind the colon has to happen, in order for "\
	+ "everything after the colon to happen. Effects that are not costs, do not "\
	+ "have to happen all. You can simply ignore anything that has no effect.\n\n"\
	+ "Press OK to hide this window. Then play double-click on the 'Discord Mod' "\
	+ "to activate its ability.",
	tutorial_steps.RESOURCES_USE_PLAYER_INPUT: '',
	tutorial_steps.RESOURCES_USED: "Great! You'll notice that the card's "\
	+ "Kudos tokens were reduced and your Kudos count has been increased.\n"\
	+ "You also lost 1 Time in order to use the Resource's ability.\n\n"\
	+ "Press OK to proceed.",
	tutorial_steps.PREP: "The last card type available is the Prep.\n"\
	+ "These cards signify single events and preparations your character is doing "\
	+ "in order to achieve a better placement in their competition.\n"\
	+ "Unlike Shaders and Resources, Prep cards are not installed. "\
	+ "They are instead used once when played and then discarded.\n\n"\
	+ "Prep cards have the following fields:\n"\
	+ "* Name: Shown on the top left.\n"\
	+ "* Costs: Kudos and Time costs are shown on the top right.\n"\
	+ "* Requirements: If the Prep has any skill, cred or motivation requirements. "\
	+ "they will be shown on the middle left area, overlapping the card illustration.\n"\
	+ "* Type: This will always be 'Prep' and will be just below the title.\n"\
	+ "* Tags: Any tags will be shown at the bottom of the illustration.\n"\
	+ "* Abilities: All prep have a positive abilities, "\
	+ "but some of them might also come with an extra cost or requirement in their use. "\
	+ "These will be explained in the main ability text.\n"\
	+ "* Affinity: The affinity of the prep, if any, will be shown "\
	+ "on the bottom right of the card. It has no mechanical impact on the game.\n"\
	+ "* Illustration: Prep have static art, which is displayed in the top middle "\
	+ "of the background of the card.\n\n"\
	+ "Press OK to proceed.",
	tutorial_steps.PREP_CONT: "Playing a prep is the same as playing a Resource,"\
	+ "You need to ensure you have enough Time and Kudos and that you match all  "\
	+ "requirements. If you don't, the card will be highlighted red.\n"\
	+ "Like Resources, a Prep's time cost is not affected by your current skill level.\n\n"\
	+ "Press OK to hide this window. Then play the 'Google-Fu' prep by either "\
	+ "double-clicking on it or by drag & dropping it to the board.\n",
	tutorial_steps.PREP_PLAYER_INPUT: '',
	tutorial_steps.PREP_PLAYED: "Excellent! You'll notice the Google-Fu effect "\
	+ "happened immediately and drew 3 extra cards from your deck to your hand.\n"\
	+ "You also lost the 1 Time it costs to play the card.\n\n"\
	+ "Prep cards are a great way to get some quick benefit without a lot "\
	+ "of setup, but they do not provide a lot of long-term impact as resources.\n\n"\
	+ "Press OK to proceed.",
	tutorial_steps.CARD_DRAW: "Speaking of card-draw it's a good time to mention "\
	+ "that there is a built-in way to draw more cards to your hand, instead of using "\
	+ "card effects.\n"\
	+ "You can simply draw a card by clicking on your deck. Doing so, costs 1 Time "\
	+ "if you have less cards than your Motivation, or 2 time if you have equal or "\
	+ "more cards in your hand than your motivation.\n\n"\
	+ "When you mouse over your deck, it will display how much time it will cost "\
	+ "to draw a new card. It up to you to decide if the extra time cost is worth "\
	+ "the benefit of playing with more options\n\n"\
	+ "Press OK to proceed.",
	tutorial_steps.TUTORS: "Some cards have permanent effects while they're in play.\n "\
	+ "One such example is the Tutor resource you've just drawn.\n"\
	+ "This specific card, increases your skill for playing low-level shaders while "\
	+ "it's installed. Given that you have some shaders that will benefit from this "\
	+ "now would be a good time to play it.\n\n"\
	+ "While we're here though, also notice the text boxes under each card's magnified view.\n"\
	+ "Other than information about the illustration, here you can see some hints "\
	+ "about the purpose of its Tags. Text with a yellow color, explains mechanical "\
	+ "effects of a tag, while white text is just for information.\n\n"\
	+ "Press OK to hide this window, then play Difios from your hand.",
	tutorial_steps.TUTOR_PLAYER_INPUT: '',
	tutorial_steps.TUTOR_PLAYED: "Now that Difios is on the board, the cost to "\
	+ "play your low-skill_req Shaders will decreate thanks to his tutoring.\n"\
	+ "To take advantage of that, use this opportunity to play the 'Fractal Pyramid' "\
	+ "and 'Light' Shaders you have in your hand. When your mouse hovers over them "\
	+ "notice how they point out their reduced cost, and which card is affecting them\n\n"\
	+ "After you've played this Shaders, you will see the 3rd placement position "\
	+ "in the competition turn green. This means that with the current cards on the "\
	+ "board, as soon as you finish this competition, you will receive the cred "\
	+ "reward for this placement.\n\n"\
	+ "Press OK to hide this window, then play 'Fractal Pyramid' and 'Light' from your hand."\
	+ "Continue drawing and playing cards until your time reaches 0 or you can do nothing else. "\
	+ "Then press 'Next Competition'. Remember to draw new cards by clicking the deck if needed.",
	tutorial_steps.FREE_PLAY: '',
	tutorial_steps.NEXT_COMPETITION: "Well done! You are 1/3 of the way through the game "\
	+ "and with some success to boot. Have you followed the instructions correctly "\
	+ "you should now have some initial cred, and some good idea how to continue. "\
	+ "playing the game.\n\nYou can continue this game until its conclusion if you wish "\
	+ "(it is winnable). Remember to use your persona ability when opportune by clicking "\
	+ "on her portrait!\n\n"\
	+ "If you preferm you can instead press the 'Main Menu' button and return to the main screen "\
	+ "where you can use the 'New Game' button to play a game using one of the starting decks.\n\n"\
	+ "Good luck, and have fun!\n\n"\
	+ "Press OK to continue.",
	tutorial_steps.END: "",
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
	tutorial_steps.SHADERS_PLAYED: ["mc_shaders","competitions", 'current_card'],
	tutorial_steps.RESOURCES: ["hand"],
	tutorial_steps.RESOURCES_CONT: ["hand"],
	tutorial_steps.RESOURCES_PLAYER_INPUT: ["all"],
	tutorial_steps.RESOURCES_PLAYED: ["mc_resources", 'current_card'],
	tutorial_steps.RESOURCES_USE_PLAYER_INPUT: ["all"],
	tutorial_steps.RESOURCES_USED: ["mc_resources", 'counters', 'current_card'],
	tutorial_steps.PREP: ["hand"],
	tutorial_steps.PREP_CONT: ["hand"],
	tutorial_steps.PREP_PLAYER_INPUT: ["all"],
	tutorial_steps.PREP_PLAYED: ['hand', 'deck', 'discard'],
	tutorial_steps.CARD_DRAW: ['deck'],
	tutorial_steps.TUTORS: ['hand'],
	tutorial_steps.TUTOR_PLAYER_INPUT: ["all"],
	tutorial_steps.TUTOR_PLAYED: ['hand', 'current_card'],
	tutorial_steps.FREE_PLAY: ["all"],
	tutorial_steps.NEXT_COMPETITION: ["all"],
	tutorial_steps.END: ["all"],
}

var current_step : int = tutorial_steps.WELCOME
var board
var board_elements : Dictionary
var proceed_button : Button
var ok_button : Button
var current_card: Card
var active_cards : Array

func _ready() -> void:
	dialog_hide_on_ok = false
	get_close_button().visible = false
	# warning-ignore:return_value_discarded
	connect("confirmed", self, "_next_tutorial_step")
	ok_button = get_ok()
	proceed_button = add_cancel("Hide")


func display_tutorial() -> void:
	match current_step:
		tutorial_steps.START_COMPETITION_PLAYER_INPUT:
			cfc.game_paused = true
			board_elements["start_button"].connect("pressed", self, "_next_tutorial_step")
		tutorial_steps.START_BUTTON_PRESSED:
			cfc.game_paused = true
			board_elements["start_button"].disconnect("pressed", self, "_next_tutorial_step")
		tutorial_steps.SHADERS:
			cfc.game_paused = true
			active_cards = cfc.NMAP.hand.get_all_cards().duplicate()
			current_card = active_cards[0]
			current_card._on_Card_mouse_entered()
		tutorial_steps.SHADERS_CONT:
			cfc.game_paused = true
			current_card = active_cards[0]
			current_card._on_Card_mouse_exited()
		tutorial_steps.SHADERS_PLAYER_INPUT:
			cfc.game_paused = false
			current_card = active_cards[1]
			# warning-ignore:return_value_discarded
			current_card.connect("card_moved_to_board", self, "_on_card_trigger")
			_tutorial_disable(true, current_card)
		tutorial_steps.SHADERS_PLAYED:
			# I need to do this, otherwise the focus highlight will be stuck
			yield(get_tree().create_timer(0.1), "timeout")
			cfc.game_paused = true
			board.mouse_pointer.current_focused_card = null
			board.mouse_pointer.overlaps = []
			cfc.NMAP.board.mouse_pointer.global_position = Vector2(0,0)
			yield(get_tree().create_timer(0.1), "timeout")
			cfc.game_paused = true
			current_card.disconnect("card_moved_to_board", self, "_on_card_trigger")
			_tutorial_disable(false)
		tutorial_steps.RESOURCES:
			cfc.game_paused = true
			current_card._on_Card_mouse_exited()
			current_card = active_cards[4]
			current_card._on_Card_mouse_entered()
		tutorial_steps.RESOURCES_CONT:
			cfc.game_paused = true
			current_card = active_cards[4]
			current_card._on_Card_mouse_exited()
		tutorial_steps.RESOURCES_PLAYER_INPUT:
			cfc.game_paused = false
			current_card = active_cards[4]
			# warning-ignore:return_value_discarded
			current_card.connect("card_moved_to_board", self, "_on_card_trigger")
			_tutorial_disable(true, current_card)
		tutorial_steps.RESOURCES_PLAYED:
			board.mouse_pointer.current_focused_card = null
			board.mouse_pointer.overlaps = []
			cfc.NMAP.board.mouse_pointer.global_position = Vector2(0,0)
			yield(get_tree().create_timer(0.1), "timeout")
			cfc.game_paused = true
			current_card.disconnect("card_moved_to_board", self, "_on_card_trigger")
			current_card._on_Card_mouse_exited()
		tutorial_steps.RESOURCES_USE_PLAYER_INPUT:
			cfc.game_paused = false
			current_card = active_cards[4]
			# warning-ignore:return_value_discarded
			current_card.connect("card_token_modified", self, "_on_card_trigger")
			_tutorial_disable(true, current_card)
		tutorial_steps.RESOURCES_USED:
			board.mouse_pointer.current_focused_card = null
			board.mouse_pointer.overlaps = []
			cfc.NMAP.board.mouse_pointer.global_position = Vector2(0,0)
			yield(get_tree().create_timer(0.1), "timeout")
			current_card.disconnect("card_token_modified", self, "_on_card_trigger")
			_tutorial_disable(false)
		tutorial_steps.PREP:
			cfc.game_paused = true
			current_card = active_cards[3]
			current_card._on_Card_mouse_entered()
		tutorial_steps.PREP_CONT:
			cfc.game_paused = true
			current_card = active_cards[3]
			current_card._on_Card_mouse_exited()
		tutorial_steps.PREP_PLAYER_INPUT:
			cfc.NMAP.board.mouse_pointer.global_position = Vector2(0,0)
			cfc.game_paused = false
			current_card = active_cards[3]
			# warning-ignore:return_value_discarded
			current_card.connect("card_moved_to_pile", self, "_on_card_trigger")
			_tutorial_disable(true, current_card)
		tutorial_steps.PREP_PLAYED:
			board.mouse_pointer.current_focused_card = null
			board.mouse_pointer.overlaps = []
			cfc.NMAP.board.mouse_pointer.global_position = Vector2(0,0)
			yield(get_tree().create_timer(0.1), "timeout")
			cfc.game_paused = true
			current_card.disconnect("card_moved_to_pile", self, "_on_card_trigger")
			_tutorial_disable(false)
		tutorial_steps.TUTORS:
			for card in cfc.NMAP.hand.get_all_cards():
				if not card in active_cards:
					active_cards.append(card)
			# warning-ignore:return_value_discarded
			cfc.game_paused = true
			_tutorial_disable(false)
		tutorial_steps.TUTOR_PLAYER_INPUT:
			cfc.game_paused = false
			current_card = active_cards[5]
			# warning-ignore:return_value_discarded
			current_card.connect("card_moved_to_board", self, "_on_card_trigger")
			_tutorial_disable(true, current_card)
		tutorial_steps.TUTOR_PLAYED:
			board.mouse_pointer.current_focused_card = null
			board.mouse_pointer.overlaps = []
			cfc.NMAP.board.mouse_pointer.global_position = Vector2(0,0)
			yield(get_tree().create_timer(0.1), "timeout")
			cfc.game_paused = true
			current_card.disconnect("card_moved_to_board", self, "_on_card_trigger")
			_tutorial_disable(false)
		tutorial_steps.FREE_PLAY:
			cfc.game_paused = false
			# warning-ignore:return_value_discarded
			board.competitions.connect("competition_ended", self, "_on_card_trigger")
		tutorial_steps.NEXT_COMPETITION:
			cfc.game_paused = true
			board.competitions.disconnect("competition_ended", self, "_on_card_trigger")
		tutorial_steps.END:
			cfc.game_paused = false
		# This is the standard tutorial step with a potential highlight
		_:
			cfc.game_paused = true
	highlight_element(HIGHLIGHTS[current_step])
	if TUTORIALS[current_step] == '':
		_hide_popup()
	else:
		dialog_text = TUTORIALS[current_step]
		_show_popup()

func highlight_element(elements: Array) -> void:
	var board_tween: Tween = board.get_node("BoardTween")
	for belement in board_elements:
		if belement in elements or elements == ['all']:
			# warning-ignore:return_value_discarded
			board_tween.interpolate_property(board_elements[belement],'modulate',
					board_elements[belement].modulate, Color(1,1,1), 0.75,
					Tween.TRANS_SINE, Tween.EASE_OUT)
		else:
			# warning-ignore:return_value_discarded
			board_tween.interpolate_property(board_elements[belement],'modulate',
					board_elements[belement].modulate, Color(0.25,0.25,0.25), 0.75,
					Tween.TRANS_SINE, Tween.EASE_OUT)
	for card in active_cards:
		if ('current_card' in elements and card == current_card) or elements == ['all']:
			# warning-ignore:return_value_discarded
			board_tween.interpolate_property(card,'modulate',
					card.modulate, Color(1,1,1), 0.75,
					Tween.TRANS_SINE, Tween.EASE_OUT)
		elif card.get_parent() == cfc.NMAP.board and elements != ['all']:
			# warning-ignore:return_value_discarded
			board_tween.interpolate_property(card,'modulate',
					card.modulate, Color(0.25,0.25,0.25), 0.75,
					Tween.TRANS_SINE, Tween.EASE_OUT)
	# warning-ignore:return_value_discarded
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

func _tutorial_disable(is_disabled, exception: Node = null) -> void:
	for card in active_cards:
		if exception == card:
			card.disable_dragging_from_hand = false
			card.tutorial_disabled = false
		else:
			card.disable_dragging_from_hand = is_disabled
			card.tutorial_disabled = is_disabled
	for node in [cfc.NMAP.deck, board, board_elements['persona']]:
		if exception == node:
			node.tutorial_disabled = false
		else:
			node.tutorial_disabled = is_disabled
