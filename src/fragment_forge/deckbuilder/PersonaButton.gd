# A single persona selection button for the deckbuilder
# It is shown in a grid
extends CenterContainer

# Emited when the persona has been selected
signal persona_selected

# The persona resource
var persona: Persona


# Sets the art and the persona details on the button
func setup(_name) -> void:
	persona = Persona.new(_name)
	$VBC/PersonaArt.texture = persona.persona_art
	$Affinity.texture = persona.affinity_icon
	$VBC/HBC/PersonaName.text = persona.persona_name
	$VBC/PersonaAbilities.text = persona.ability


func _on_PersonaButton_pressed() -> void:
	emit_signal("persona_selected", persona)
