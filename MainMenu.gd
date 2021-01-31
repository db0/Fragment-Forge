tool
extends Panel

var shader_time := 0.0
var frame := 0
var change_time := 0.0
var shader_properties: ShaderProperties

func _ready() -> void:
	cfc.game_rng.randomize()
	change_shader()

func _process(delta: float) -> void:
	material.set_shader_param('iTime', shader_time)
	material.set_shader_param('iFrame', frame)
	if Engine.editor_hint:	
		material.set_shader_param('is_card', false)
	shader_time += delta
	change_time += delta
	frame += 1
	if not Engine.editor_hint and change_time >=10: 
		change_time = 0.0
		change_shader()

func change_shader(shader_name = null) -> void:
	material = ShaderMaterial.new()
	if not shader_name:
		# These are shaders which don't looks that good in a bigger version
		# So we want to avoid having them in the main menu background
		var unimpressive_shaders = [
			"Light",
			"Cloud",
			"Fractal Tiling",
			]
		# Using split() instead of rstrip() as the later seems to be eating
		# characters for some reason
		while not shader_name or shader_name in unimpressive_shaders:
			shader_name = grab_random_shader().split(".")[0]
	material.shader = load("res://shaders/" + shader_name + ".shader")
	shader_properties = ShaderProperties.new(material)
	shader_properties.init_shader(shader_name, false)
	material.set_shader_param('is_card', false)

# Returns a Dictionary with the combined Script definitions of all set files
static func grab_random_shader() -> String:
	var files := []
	var dir := Directory.new()
	
	# warning-ignore:return_value_discarded
	dir.open("res://shaders")
	# warning-ignore:return_value_discarded
	dir.list_dir_begin()
	while true:
		var file := dir.get_next()
		if file == "":
			break
		elif file.ends_with(".shader"):
			files.append(file)
	dir.list_dir_end()
	CFUtils.shuffle_array(files)
	return(files[0])


