extends HBoxContainer

var persona: Persona

func _ready() -> void:
	pass

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
	
