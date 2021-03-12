# This class defines how the properties of the [Card] definition are to be
# used during `setup()`
#
# All the properties defined on the card json will attempt to find a matching
# label node inside the cards _card_labels dictionary.
# If one was not found, an error will be printed.
#
# The exception is properties starting with _underscore. This are considered
# Meta properties and the game will not attempt to display them on the card
# front.
class_name CardConfig
extends Reference

# I use this dict so I can quickly rename a whole card type to comething else
# without breaking my code
const CardTypes := {
	"ACTION": "Prep",
	"SHADER": "Shader",
	"RESOURCE": "Resource"
}
const Affinities := {
	"NEUTRAL": {
		"name":"Neutral",
		"icon": preload("res://assets/icons/NEUTRAL.png")
	},
	"ART": {
		"name":"Fractal Minds",
		"icon": preload("res://assets/icons/ART.png")
	},
	"ZIP": {
		"name":"Zippers",
		"icon": preload("res://assets/icons/ZIP.png")
	},
	"WIN": {
		"name":"Champions",
		"icon": preload("res://assets/icons/WIN.png")
	},
}

# Properties which are placed as they are in appropriate labels
const PROPERTIES_STRINGS := ["Type", "Requirements", "Abilities"]
# Properties which are converted into string using a format defined in setup()
const PROPERTIES_NUMBERS := [
		"Time",
		"Value",
		"Kudos",
		"skill_req",
		"cred_req",
		"motivation_req"]
const NUMBER_WITH_LABEL := []
# Properties provided in a list which are converted into a string for the
# label text, using the array_join() method
const PROPERTIES_ARRAYS := ["Tags"]
# This property matches the name of the scene file (without the .tcsn file)
# which is used as a template For this card.
const SCENE_PROPERTY = "Type"
const NUMBERS_HIDDEN_ON_0 := [
		"Value",
		"Kudos",
		"skill_req",
		"cred_req",
		"motivation_req"]
const TYPES_TO_HIDE_IN_DECKBUILDER := []
const EXPLANATIONS = {
	"Unique": "Unique: Only one card with this name can be Installed",
	"Restricted": "Restricted: You can only have 1 of these cards in your deck",
	"Collaborator": "Collaborator: Discarded at the end of the current competition",
	"Reputation": "Reputation: Can only have 1 Reputation installed",
	"Burnout": "(Burnout cards require Motivation to use)",
	"Obscure": "(Obscure cards do not like card-draw effects)",
	"Tutor": "(Tutors help install or improve Shaders)",
	"Contact": "(Contacts have abilities which give Time back)",
	"Knowledge": "(Knowledge cards have abilities which draw cards)",
	"Community": "(Community cards provide Kudos)",
}
const ACTIVE_TAGS = [
	"Unique",
	"Restricted",
	"Collaborator",
	"Reputation",
]
