class_name FFUtils
extends Reference


# Returns a Dictionary with the combined Script definitions of all set files
static func grab_random_texture() -> Dictionary:
	# The higher the number, the more likely the textures in that directory
	# to be chosen
	var directories := {
		"res://shaders/textures/cc0textures/": 1,
		"res://shaders/textures/pixabay/": 2,
	}
	var random_dir := []
	for dir in directories:
		for iter in range(directories[dir]):
			random_dir.append(dir)
	var rng = CFUtils.randi_range(0,random_dir.size() - 1)
	var directory = random_dir[rng]
	var textures := CFUtils.list_files_in_directory(directory)
	CFUtils.shuffle_array(textures)
	var new_texture = ImageTexture.new();
	var tex = load(directory + textures[0])
	var image = tex.get_data()
	new_texture.create_from_image(image)
	return(new_texture)
	
static func grab_texture(path: String) -> Dictionary:
	var new_texture = ImageTexture.new();
	var tex = load(path)
	var image = tex.get_data()
	new_texture.create_from_image(image)
	return(new_texture)

static func rnd_color() -> Vector3:
	var r := 1.0
	var g := 1.0
	var b := 1.0
	while r > 0.7 and g > 0.7 and b > 0.7:
		r = CFUtils.randf_range(0.0,0.9)
		g = CFUtils.randf_range(0.0,0.9)
		b = CFUtils.randf_range(0.0,0.9)
	return(Vector3(r,g,b))
