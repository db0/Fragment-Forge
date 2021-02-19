class_name ShaderProperties
extends Reference

var shader_params := {}
var material: Material
var shader_time_offset := 0.0

func _init(_material: Material) -> void:
	material = _material

func init_shader(shader_name: String, is_card := true) -> void:
	if is_card:
		shader_time_offset = CFUtils.randf_range(0.1,100.0)
	match shader_name:
		"Simple Colours":
			_set_shader_param('speed_color1', CFUtils.randf_range(0.3,1.0))
			_set_shader_param('speed_color2', CFUtils.randf_range(0.3,1.0))
			_set_shader_param('style', CFUtils.randi()%2)
		"Mandelbrot":
			_set_shader_param('zoom_choice', CFUtils.randi()%9)
		"Strings":
			_set_shader_param('form', Vector3(
							CFUtils.randf_range(-2.0,2.0),
							CFUtils.randf_range(-4.0,4.0),
							CFUtils.randf_range(-4.0,4.0)))
		"Twister":
			if is_card:
				_set_shader_param('multiplier', CFUtils.randf_range(5.0,10.0))
			else:
				_set_shader_param('multiplier', CFUtils.randf_range(10.0,15.0))
			var texture = FFUtils.grab_random_texture()
			_set_shader_param('iChannel1', texture)
			if not CFUtils.randi() % 8:
				_set_shader_param('columns', true)
		"Voronoi Column Tracing":
			var USE_COLORS = CFUtils.randi()%3
			if USE_COLORS == 0:
				USE_COLORS = 3
			_set_shader_param('USE_COLORS', USE_COLORS)
			# I want 1/5 shaders of this type to not rotate
			if not CFUtils.randi() % 5:
				_set_shader_param('ROTATE', 0)
			# I want 1/5 shaders of this type to not wave
			if not CFUtils.randi() % 5:
				_set_shader_param('WAVING', 0)
			_set_shader_param('ANIM_SPEED', CFUtils.randf_range(0.1,1.0))
			var texture = FFUtils.grab_random_texture()
			_set_shader_param('iChannel1', texture)
		"Seascape":
			_set_shader_param('SEA_HEIGHT', CFUtils.randf_range(0.3,0.8))
			_set_shader_param('SEA_CHOPPY', CFUtils.randf_range(2.0,6.0))
			_set_shader_param('SEA_SPEED', CFUtils.randf_range(0.7,2.0))
			_set_shader_param('WATER_TYPE', CFUtils.randi()%4)
		"Fractal Tiling":
			_set_shader_param('contrast', Vector3(
					CFUtils.randf_range(0.5,1.0),
					CFUtils.randf_range(0.5,1.0),
					CFUtils.randf_range(0.5,1.0)))
			if is_card:
				_set_shader_param('zoom', CFUtils.randf_range(96.0,256.0))
			else:
				_set_shader_param('zoom', CFUtils.randf_range(256.0,300.0))
			_set_shader_param('speed_x', CFUtils.randf_range(1.0,5.0))
			_set_shader_param('speed_y', CFUtils.randf_range(1.0,5.0))
			if not CFUtils.randi() % 2:
				_set_shader_param('direction_x', -1.0)
			if not CFUtils.randi() % 2:
				_set_shader_param('direction_y', -1.0)
		"Sierpinski":
			# One in four sierpinski shaders will be upside down
			if not CFUtils.randi() % 4:
				_set_shader_param('orient', -1.0)
		"Raycast":
			_set_shader_param('iChannel0', FFUtils.grab_random_texture())
			_set_shader_param('iChannel1', FFUtils.grab_random_texture())
		"Ether":
			_set_shader_param('sharpness', CFUtils.randi_range(5,10))
		"Spine":
			# Only texture that doesn't make the camera run into the wall often
			_set_shader_param('iChannel0', FFUtils.grab_texture("res://shaders/textures/cc0textures/Ground040_1K_Color.jpg"))
			_set_shader_param('iChannel1', FFUtils.grab_texture("res://shaders/textures/pixabay/background-4097561_640.jpg"))
		"Plasma Globe":
			_set_shader_param('iChannel0', FFUtils.grab_random_texture())
			_set_shader_param('NUM_RAYS', CFUtils.randf_range(10.0,30.0))
		"Noise Pulse":
			_set_shader_param('iChannel0', FFUtils.grab_random_texture())
			_set_shader_param('tint', FFUtils.rnd_color())
			if is_card:
				_set_shader_param('multiplier', CFUtils.randf_range(4.0,10.0))
			else:
				_set_shader_param('multiplier', CFUtils.randf_range(15.0,20.0))
		_:
			pass

# Sets parameters for the shader, and also stores them in a dictionary to be
# reused by the viewport duplicate.
func _set_shader_param(parameter: String, value) -> void:
	material.set_shader_param(parameter, value)
	shader_params[parameter] = value
