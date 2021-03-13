extends DBDeckSummaries

signal persona_selected

const persona_button = preload("res://src/fragment_forge/deckbuilder/PersonaButton.tscn")

var maximum_inspiration := 0
var affinity := "NEUTRAL"
var persona_selections_populated := false

var persona: Persona
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


func _on_PersonaSelect_pressed() -> void:
	if not persona_selections_populated:
		for p in PersonaDefinitions.PERSONAS.keys():
			var pb = persona_button.instance()
			pb.setup(p)
			$PersonaSelection/GridContainer.add_child(pb)
			pb.connect("persona_selected", self, "persona_selected")
		persona_selections_populated = true
	$PersonaSelection.popup_centered_minsize()

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
