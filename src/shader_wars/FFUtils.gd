class_name FFUtils
extends Reference


# Returns a Dictionary with the combined Script definitions of all set files
static func grab_random_texture() -> Dictionary:
	var textures := CFUtils.list_files_in_directory(
				"res://shaders/textures/cc0textures/")
	CFUtils.shuffle_array(textures)
	var new_texture = ImageTexture.new();
	var tex = load("res://shaders/textures/cc0textures/" + textures[0])
	var image = tex.get_data()
	new_texture.create_from_image(image)
	return(new_texture)
