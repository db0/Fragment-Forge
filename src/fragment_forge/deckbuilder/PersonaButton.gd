extends CenterContainer

signal persona_selected

var persona: Persona


func setup(_name) -> void:
	persona = Persona.new(_name)
	$VBC/PersonaArt.texture = persona.persona_art
	$Affinity.texture = persona.affinity_icon
	$VBC/HBC/PersonaName.text = persona.persona_name
	$VBC/PersonaAbilities.text = persona.ability


func _on_PersonaButton_pressed() -> void:
	emit_signal("persona_selected", persona)
