extends Panel

# The time it takes to switch from one menu tab to another
const menu_switch_time = 0.35

# Shader properties.
var shader_time := 0.0
var frame := 0
var change_time := 0.0
var shader_properties: ShaderProperties

onready var main_menu := $MainMenu
onready var settings_menu := $SettingsMenu
onready var new_game_menu := $NewGame
onready var deck_builder := $DeckBuilder
onready var title := $Title

func _ready() -> void:
	cfc.game_rng.randomize()
	change_shader()
	settings_menu.rect_position.x = get_viewport().size.x
	new_game_menu.rect_position.x = get_viewport().size.x
	deck_builder.rect_position.x = -get_viewport().size.x
	new_game_menu.back_button.connect("pressed", self, "_on_NewGame_Back_pressed")
	settings_menu.back_button.connect("pressed", self, "_on_Setings_Back_pressed")
	deck_builder.back_button.connect("pressed", self, "_on_DeckBuilder_Back_pressed")
	initiate_sample_decks()

func _process(delta: float) -> void:
	material.set_shader_param('iTime', shader_time)
	material.set_shader_param('iFrame', frame)
	if Engine.editor_hint:
		material.set_shader_param('is_card', false)
	shader_time += delta
	change_time += delta
	frame += 1
	if not Engine.editor_hint and change_time >=10:
		if not $Tween.is_active():
			$Tween.interpolate_property(self,'self_modulate',
					self_modulate, Color(0,0,0), 2.0,
					Tween.TRANS_QUAD, Tween.EASE_IN)
			$Tween.start()
			yield($Tween, "tween_all_completed")
			change_time = 0.0
			change_shader()
			self_modulate = Color(0,0,0)
			$Tween.interpolate_property(self,'self_modulate',
					self_modulate, Color(1,1,1), 2.0,
					Tween.TRANS_SINE, Tween.EASE_OUT)
			$Tween.start()

func change_shader(shader_name = null) -> void:
	material = ShaderMaterial.new()
	if not shader_name:
		# These are shaders which don't looks that good in a bigger version
		# So we want to avoid having them in the main menu background
		var unimpressive_shaders = [
			"Simple Colours",
			"Light",
			"Cloud",
			"Fractal Tiling",
			"Warping",
			]
		# Using split() instead of rstrip() as the later seems to be eating
		# characters for some reason
		while not shader_name or shader_name in unimpressive_shaders:
			shader_name = grab_random_shader().split(".")[0]
	material.shader = load("res://shaders/" + shader_name + ".shader")
	shader_properties = ShaderProperties.new(material)
	shader_properties.init_shader(shader_name, false)
	material.set_shader_param('is_card', false)


func initiate_sample_decks() -> void:
	cfc.game_settings['sample_decks_loaded'] = cfc.game_settings.get('sample_decks_loaded', false)
	if not cfc.game_settings.sample_decks_loaded:
		var dir = Directory.new()
		if not dir.dir_exists(CFConst.DECKS_PATH):
			dir.make_dir(CFConst.DECKS_PATH)
		var sample_decks = load(CFConst.PATH_CUSTOM + "decks/SampleDecks.gd")
		for deck in sample_decks.decks:
			deck['total'] = 0
			for card in deck.cards:
				deck['total'] += deck.cards[card]
			var file = File.new()
			file.open(CFConst.DECKS_PATH + deck.name + '.json', File.WRITE)
			file.store_string(JSON.print(deck, '\t'))
			file.close()
	cfc.set_setting('sample_decks_loaded',true)


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


func _on_NewGame_deck_loaded(deck) -> void:
	ffc.current_deck = deck.cards
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://src/fragment_forge/Main.tscn")


func _on_Settings_pressed() -> void:
	$MenuTween.interpolate_property(main_menu,'rect_position:x',
			main_menu.rect_position.x, -get_viewport().size.x, menu_switch_time,
			Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	$MenuTween.interpolate_property(settings_menu,'rect_position:x',
			settings_menu.rect_position.x, 0, menu_switch_time,
			Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	$MenuTween.start()

func _on_Setings_Back_pressed() -> void:
	$MenuTween.interpolate_property(settings_menu,'rect_position:x',
			settings_menu.rect_position.x, get_viewport().size.x, menu_switch_time,
			Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	$MenuTween.interpolate_property(main_menu,'rect_position:x',
			main_menu.rect_position.x, 0, menu_switch_time,
			Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	$MenuTween.start()

func _on_DeckBuilder_pressed() -> void:
	$MenuTween.interpolate_property(main_menu,'rect_position:x',
			main_menu.rect_position.x, get_viewport().size.x, menu_switch_time,
			Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	$MenuTween.interpolate_property(title,'rect_position:x',
			title.rect_position.x, get_viewport().size.x, menu_switch_time,
			Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	$MenuTween.interpolate_property(deck_builder,'rect_position:x',
			deck_builder.rect_position.x, 0, menu_switch_time,
			Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	$MenuTween.start()

func _on_DeckBuilder_Back_pressed() -> void:
	$MenuTween.interpolate_property(deck_builder,'rect_position:x',
			deck_builder.rect_position.x, -get_viewport().size.x, menu_switch_time,
			Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	$MenuTween.interpolate_property(main_menu,'rect_position:x',
			main_menu.rect_position.x, 0, menu_switch_time,
			Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	$MenuTween.interpolate_property(title,'rect_position:x',
			title.rect_position.x, 0, menu_switch_time,
			Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	$MenuTween.start()


func _on_NewGame_pressed() -> void:
	$MenuTween.interpolate_property(main_menu,'rect_position:x',
			main_menu.rect_position.x, -get_viewport().size.x, menu_switch_time,
			Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	$MenuTween.interpolate_property(new_game_menu,'rect_position:x',
			new_game_menu.rect_position.x, 0, menu_switch_time,
			Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	$MenuTween.start()


func _on_NewGame_Back_pressed() -> void:
	$MenuTween.interpolate_property(new_game_menu,'rect_position:x',
			new_game_menu.rect_position.x, get_viewport().size.x, menu_switch_time,
			Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	print('debug')
	$MenuTween.interpolate_property(main_menu,'rect_position:x',
			main_menu.rect_position.x, 0, menu_switch_time,
			Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	$MenuTween.start()
