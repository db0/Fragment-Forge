class_name Persona
extends Resource

var persona_name: String
var affinity: String
var inspiration: int
var ability: String
var persona_art: ImageTexture
var affinity_icon: ImageTexture
var scripts : Dictionary
var scripts_frequency : String

func _init(_name) -> void:
	persona_name = _name
	var persona_dict : Dictionary = PersonaDefinitions.PERSONAS.get(persona_name)
	affinity = persona_dict.Affinity
	inspiration = persona_dict.Inspiration
	ability = persona_dict.Ability
	persona_art = get_persona_art()
	affinity_icon = get_affinity_icon()
	if persona_dict.get("scripts"):
		scripts = persona_dict.get("scripts")
	scripts_frequency = persona_dict.scripts_frequency

func get_persona_art() -> ImageTexture:
	var persona_texture: ImageTexture = null
	var persona_art_file: String = "res://assets/images/personas/" + persona_name
	var new_texture = ImageTexture.new();
	for extension in ['.jpg','.jpeg','.png']:
		if ResourceLoader.exists(persona_art_file + extension):
			var tex = load(persona_art_file + extension)
			var image = tex.get_data()
			new_texture.create_from_image(image)
			persona_texture = new_texture
	if not persona_texture:
		persona_texture = get_undecided_texture()
	return(persona_texture)

func get_affinity_icon() -> ImageTexture:
	var icon_texture = ImageTexture.new();
	var image =  CardConfig.Affinities[affinity].icon.get_data()
	icon_texture.create_from_image(image)
	return(icon_texture)

static func get_undecided_texture() -> ImageTexture:
	var new_texture = ImageTexture.new();	
	var tex = load("res://assets/images/personas/undecided.png")
	var image = tex.get_data()
	new_texture.create_from_image(image)
	return(new_texture)
