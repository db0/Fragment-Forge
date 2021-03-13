extends DBDeckSummaries

# Emited when a persona selected changes, in order to recalculate 
# deck card influences
signal persona_selected

const persona_button = preload("res://src/fragment_forge/deckbuilder/PersonaButton.tscn")

# Stored the inspiration provided by the persona
var maximum_inspiration := 0
# The persona's affnity keyword
var affinity := "NEUTRAL"
# A flag to avoid creating new persona buttons every time in the grid
var persona_selections_populated := false

# The persona resource
var persona: Persona
# These will store the path for the various labels in setup()
var persona_image: Button
var persona_name: Label
var persona_ability: Label
var affinity_label: Label
var affinity_icon: TextureRect
var inpiration_label : Label

func setup() -> void:
	inpiration_label = $VBC/Inspiration
	deck_min_label = $VBC/CardCount
	persona_name = $VBC/PersonaName
	persona_ability = $VBC/PersonaAbility
	persona_image = $PersonaSelect
	affinity_icon = $VBC/HBC/AffinityIcon
	affinity_label = $VBC/HBC/AffinityName


# Triggered after the persona select button is pressed.
# Opens a grid selection box for the player to select a persona
# for their deck
func _on_PersonaSelect_pressed() -> void:
	var grid := $PersonaSelection/ScrollContainer/GridContainer
	if not persona_selections_populated:
		for p in PersonaDefinitions.PERSONAS.keys():
			var pb = persona_button.instance()
			pb.setup(p)
			grid.add_child(pb)
			pb.connect("persona_selected", self, "persona_selected")
		persona_selections_populated = true
	$PersonaSelection.popup_centered_minsize()
	if grid.rect_size.x < 1500:
		$PersonaSelection/ScrollContainer.rect_min_size.x = grid.rect_size.x
	else:
		$PersonaSelection/ScrollContainer.rect_min_size.x = 1500
	if grid.rect_size.y < 700:
		$PersonaSelection/ScrollContainer.rect_min_size.y = grid.rect_size.y
	else:
		$PersonaSelection/ScrollContainer.rect_min_size.y = 750
	# Have to do this twice because the grid size is not set until
	# it's displayed once first
	$PersonaSelection.popup_centered_minsize()

# Sets the values for the deck summary
# And triggers the recalculation of influences.
func persona_selected(p: Persona) -> void:
	persona = p
	persona_name.text = persona.persona_name
	persona_ability.text = persona.ability
	persona_image.icon = persona.persona_art
	affinity_icon.texture = persona.affinity_icon
	affinity_label.text = CardConfig.Affinities[persona.affinity]["name"]
	maximum_inspiration = persona.inspiration
	affinity = persona.affinity
	$PersonaSelection.hide()
	emit_signal("persona_selected")

func reset_persona() -> void:
	persona = null
	persona_name.text = 'Please select Persona!'
	persona_ability.text = ''
	persona_image.icon = Persona.get_undecided_texture()
	affinity_icon.texture = null
	affinity_label.text = ''
	maximum_inspiration = 0
	affinity = 'NEUTRAL'
	emit_signal("persona_selected")
