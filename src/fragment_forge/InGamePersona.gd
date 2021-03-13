# Holds the info about the persona assigned to this deck
# Also responsible for triggering manual scripts from this persona
extends HBoxContainer

# The persona resource
var persona: Persona

# Called when the deck is first loaded, to populate the various fields
# and textures
func setup() -> void:
	if ffc.current_persona:
		persona = ffc.current_persona
		$Persona.icon = persona.persona_art
		$VBC/PersonaName.text = persona.persona_name
		$VBC/PersonaAbilities.text = persona.ability
	else:
		$Persona.icon = Persona.get_undecided_texture()
		$VBC/PersonaName.text = "Persona not defined!"
		$VBC/PersonaAbilities.text = "N/A"
	
