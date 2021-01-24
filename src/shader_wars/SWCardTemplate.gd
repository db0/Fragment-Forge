class_name SWCard
extends Card

# Switch to know when the player attempted to activate an action card
# by dragging it to the board area
var attempted_action_drop_to_board := false

onready var modified_costs_popup = $ModifiedCostsPopup

func _process(_delta: float) -> void:
	_extra_state_processing()
	if cfc._debug and not get_parent().is_in_group("piles"):
		if properties.Type == CardConfig.CardTypes.SHADER:
			$Debug/ModifiedCost.text = "ModCost: "\
					+ str(get_skill_modified_shader_time_cost(
						properties.get("skill_req", 0),
						cfc.NMAP.board.counters.get_counter("skill", self),
						properties.get("Time", 0)
					))

func setup() -> void:
	.setup()
	if properties.Type == CardConfig.CardTypes.SHADER:
#		print_debug(card_front.art.material)
		var shader_name: String = "res://shaders/" + card_name + ".shader"
		var check_shader = File.new()
		if check_shader.file_exists(shader_name):
			card_front.material = ShaderMaterial.new()
			card_front.material.shader = load("res://shaders/" + card_name + ".shader")
			match card_name:
				"Simple Colours":
					card_front.material.set_shader_param(
							'speed_color1',
							cfc.game_rng.randf_range(0.3,1.0))
					card_front.material.set_shader_param(
							'speed_color2',
							cfc.game_rng.randf_range(0.3,1.0))
					card_front.material.set_shader_param(
							'style',
							cfc.game_rng.randi()%2)
				"Mandelbrot":
					card_front.material.set_shader_param(
							'zoom_choice',
							cfc.game_rng.randi()%6)
				_:
					card_front.material.set_shader_param(
							'seed',
							cfc.game_rng.randf_range(0.1,100.0))

func check_play_costs() -> Color:
	var ret : Color = CFConst.CostsState.OK
	var time_cost = get_modified_time_cost().modified_cost
	var kudos_cost = get_modified_kudos_cost().modified_cost

	if time_cost > cfc.NMAP.board.counters.get_counter("time", self):
		ret = CFConst.CostsState.IMPOSSIBLE
	elif time_cost > properties.get("Time", 0):
		ret = CFConst.CostsState.INCREASED
	elif time_cost < properties.get("Time", 0):
		ret = CFConst.CostsState.DECREASED

	if kudos_cost > cfc.NMAP.board.counters.get_counter("kudos", self):
		ret = CFConst.CostsState.IMPOSSIBLE
	# We only want the highlight to change if it's still the default
	elif kudos_cost > properties.get("Kudos", 0) \
			and ret == CFConst.CostsState.OK:
		ret = CFConst.CostsState.INCREASED
	elif kudos_cost < properties.get("Kudos", 0) \
			and ret == CFConst.CostsState.OK:
		ret = CFConst.CostsState.DECREASED
	# For shaders, the skill_rqa is already taken into account
	# inside get_modified_time_cost()
	if properties.get("skill_req", 0) > \
			cfc.NMAP.board.counters.get_counter("skill", self) \
			and properties.Type != CardConfig.CardTypes.SHADER:
		ret = CFConst.CostsState.IMPOSSIBLE

	if properties.get("cred_req", 0) > \
			cfc.NMAP.board.counters.get_counter("cred", self):
		ret = CFConst.CostsState.IMPOSSIBLE

	if properties.get("motivation_req", 0) > \
			cfc.NMAP.board.counters.get_counter("motivation", self):
		ret = CFConst.CostsState.IMPOSSIBLE

	if check_unique_conflict():
		ret = CFConst.CostsState.IMPOSSIBLE
	return(ret)

# Calculates how much time a card will cost, after taking into account
# player skill level (shaders only) and alterants on the table.
#
# Returns a dictionary with the following keys:
# * modified_cost (int): The final cost of the card
# * skill_modifier (int): The modifier to the time cost due to the player's skill
#	level
# * cards_modifier: The modifier to the time cost due to alterants on the board
# * alterant_cards: A dictionary with two keys, "time" and "skill".
#	Each key holds a dictionary with the alterants_details, as returned
#	from CFScriptUtils.get_altered_value()
func get_modified_time_cost() -> Dictionary:
	var time_cost_details : Dictionary =\
			get_property_and_alterants("Time")
	var modified_cost : int = time_cost_details.value
	var skill_counter_details : Dictionary =\
			cfc.NMAP.board.counters.get_counter_and_alterants("skill", self)
	if properties.Type == CardConfig.CardTypes.SHADER:
		modified_cost = get_skill_modified_shader_time_cost(
				properties.get("skill_req", 0),
				skill_counter_details.count,
				modified_cost)
	var return_dict = {
		"modified_cost": modified_cost,
		"skill_modifier": modified_cost - time_cost_details.value,
		"cards_modifier": time_cost_details.alteration.value_alteration,
		"alterant_cards": {
			"card": merge_modifier_dicts(time_cost_details),
			"skill": merge_modifier_dicts(skill_counter_details)
		}
	}
	return(return_dict)

# Calculates how much kudos a card will cost, after taking into account
# alterants on the table.
#
# Returns a dictionary with the following keys:
# * modified_cost (int): The final kudos cost of the card
# * cards_modifier: The modifier to the kudos cost due to alterants on the board
# * alterant_cards: A dictionary with the alterants_details, as returned
#	from CFScriptUtils.get_altered_value()
func get_modified_kudos_cost() -> Dictionary:
	var kudos_cost_details : Dictionary =\
			get_property_and_alterants("Kudos")
	var modified_cost : int = kudos_cost_details.value
	var return_dict = {
		"modified_cost": modified_cost,
		"cards_modifier": kudos_cost_details.alteration.value_alteration,
		"alterant_cards": merge_modifier_dicts(kudos_cost_details)
	}
	return(return_dict)

# Merges alterant modifiers with temp_modifiers into one Dictionary
func merge_modifier_dicts(container_dict) -> Dictionary:
	var modifier_details : Dictionary =\
			container_dict.alteration.alterants_details.duplicate()
	for c in container_dict.temp_modifiers.modifier_details:
		if c in modifier_details.keys():
			modifier_details[c] += container_dict.temp_modifiers.modifier_details[c]
		else:
			modifier_details[c] = container_dict.temp_modifiers.modifier_details[c]
	return(modifier_details)

# Calculates the time cost of a shader adjusted by the player's skill
static func get_skill_modified_shader_time_cost(
		skill_req: int,
		current_skill: int,
		time_cost: int) -> int:
	var final_cost : int
	if current_skill + 1 < skill_req:
		# We put a sufficiently large number to make the cost impossible
		# When the skill req is higher by 2 or more
		final_cost = 1000
	elif current_skill < skill_req:
		# Making more skill-advanced shaders doubles their time and adds 1 on top
		final_cost = skill_req + time_cost + 1
	elif current_skill > skill_req:
		# Making less advanced shaders simply reduces their time needs by 1
		# to a maximum of half (rounded up)
		var max_reduction = round(float(time_cost) / 2)
		final_cost = time_cost + skill_req - current_skill
		if final_cost < max_reduction:
			final_cost = max_reduction
	else:
		final_cost = time_cost
	return(final_cost)

# Sets a flag when an actio card is dragged to the board manually
# which will trigger the game to execute its scripts
func common_pre_move_scripts(new_container: Node, old_container: Node, scripted_move: bool) -> Node:
	var target_container := new_container
	if new_container == cfc.NMAP.board \
			and old_container == cfc.NMAP.hand \
			and properties.Type == CardConfig.CardTypes.ACTION:
		# We don't pay the costs for Prep cards, as this is handled
		# in the common_pre_execution_scripts() method
		attempted_action_drop_to_board = true
	return(target_container)

# Executes some extra logic depending on the type of card moved
func common_post_move_scripts(new_container: Node, old_container: Node, scripted_move: bool) -> void:
	# If a non-shader was moved to the board from hand, we want to pay its costs
	if new_container == cfc.NMAP.board\
			and old_container == cfc.NMAP.hand\
			and not scripted_move:
		pay_play_costs()
	# if an action was dragged to the board, it will have returned to hand now
	# and have a special flag set. Therefore we execute its scripts
	if attempted_action_drop_to_board:
		execute_scripts()
		attempted_action_drop_to_board = false

# Retrieves the card scripts either from those defined on the card
# itself, or from those defined in the script definition files
#
# Returns a dictionary of card scripts for this specific card
# based on the current trigger.
func retrieve_card_scripts(trigger: String) -> Dictionary:
	var found_scripts = .retrieve_card_scripts(trigger)
	if trigger == "manual" and get_state_exec() == "hand":
		found_scripts = insert_payment_costs(found_scripts)
		if typeof(found_scripts["hand"]) == TYPE_ARRAY:
			if properties.Type == CardConfig.CardTypes.ACTION:
				found_scripts["hand"] += generate_discard_action_tasks()
			else:
				found_scripts["hand"] += generate_install_tasks()
		else:
			for key in found_scripts["hand"]:
				if properties.Type == CardConfig.CardTypes.ACTION:
					found_scripts["hand"][key] += generate_discard_action_tasks()
				else:
					found_scripts["hand"][key] += generate_install_tasks()
	return(found_scripts)

# Inserts time and kudos payment costs into a card's scripts
# so that they are all processed by the ScriptingEngine
func insert_payment_costs(found_scripts) -> Dictionary:
	var array_with_costs := generate_play_costs_tasks()
	var state_scripts = found_scripts.get("hand",[])
	if typeof(state_scripts) == TYPE_ARRAY:
		array_with_costs += state_scripts
		found_scripts["hand"] = array_with_costs
	else:
		for key in state_scripts:
			var temp_array = array_with_costs.duplicate()
			temp_array += state_scripts[key]
			found_scripts["hand"][key] = temp_array
	return(found_scripts)

# Adds payment costs into a card's custom scripts under a special trigger
# and executes them so that they are all processed by the ScriptingEngine
func pay_play_costs() -> void:
	var state_exec = get_state_exec()
	scripts["payments"] = {}
	scripts["payments"][state_exec] = generate_play_costs_tasks()
	execute_scripts(self,"payments")
	scripts["payments"].clear()

# Uses a template to create task definitions for paying time and kudos costs
# then returns it to the calling function to execute or insert it into
# the cards existing scripts for its state.
func generate_play_costs_tasks() -> Array:
	var payment_script_template := {
			"name": "mod_counter",
			"is_cost": true,
			"modification": 0,
			"tags": ["PlayCost"],
			"counter_name":  "counter"}
	var pay_tasks = []
	var time_cost = get_modified_time_cost().modified_cost
	if time_cost:
		var cost_script = payment_script_template.duplicate()
		cost_script["modification"] = -time_cost
		cost_script["counter_name"] = "time"
		pay_tasks.append(cost_script)
	var kudos_cost = get_modified_kudos_cost().modified_cost
	if kudos_cost:
		var cost_script = payment_script_template.duplicate()
		cost_script["modification"] = -kudos_cost
		cost_script["counter_name"] = "kudos"
		pay_tasks.append(cost_script)
	return(pay_tasks)

# Uses a template to create task definitions for discarding a card
# then returns it to the calling function to execute or insert it into
# the cards existing scripts for its state.
func generate_discard_action_tasks() -> Array:
	var discard_script_template := {
			"name": "move_card_to_container",
			"subject": "self",
			"dest_container": cfc.NMAP.discard}
	var discard_tasks = [discard_script_template]
	return(discard_tasks)

# Uses a template to create task definitions for placing a card to the table
# then returns it to the calling function to execute or insert it into
# the cards existing scripts for its state.
func generate_install_tasks() -> Array:
	var install_script_template := {
			"name": "move_card_to_board",
			"subject": "self",
			"is_cost": true,
			SP.KEY_GRID_NAME: mandatory_grid_name}
	var install_tasks = [install_script_template]
	return(install_tasks)

# Extra _process logic for SW
func _extra_state_processing() -> void:
	match state:
		# If a card is focused in hand, we want to also display its
		# Modified time cost popup on the side.
		CardState.FOCUSED_IN_HAND:
			modified_costs_popup.rect_global_position = Vector2(
					global_position.x
					+ 10
					+ card_size.x
					* scale.x,
					global_position.y)
			# To avoid the Kudos cost falling outside the viewport
			# When the length of the popup is too big, we reposition it
			# to the top of the card
			if modified_costs_popup.rect_global_position.x\
					+ modified_costs_popup.rect_size.x > get_viewport().size.x:
				modified_costs_popup.rect_global_position = Vector2(
						global_position.x
						+ card_size.x / 2 * scale.x
						- modified_costs_popup.rect_size.x / 2,
						global_position.y
						- modified_costs_popup.rect_size.y - 10)
			if not modified_costs_popup.visible:
				var modified_time_costs := get_modified_time_cost()
				modified_costs_popup.update_time_labels(
						modified_time_costs.modified_cost,
						properties.get("Time", 0),
						modified_time_costs.skill_modifier,
						modified_time_costs.cards_modifier,
						modified_time_costs.alterant_cards)
				var modified_kudos_costs := get_modified_kudos_cost()
				modified_costs_popup.update_kudos_labels(
						modified_kudos_costs.modified_cost,
						properties.get("Kudos", 0),
						modified_kudos_costs.cards_modifier,
						modified_kudos_costs.alterant_cards)
				# Cannot use popup() here, is it somehow interrupts
				# The card dropping.
				modified_costs_popup.reset_sizes()
				modified_costs_popup.visible = true
		_:
			if modified_costs_popup.visible:
				modified_costs_popup.visible = false


func check_unique_conflict() -> bool:
	var unique_conflict := false
	if "Unique" in properties.get("Tags", []):
		for card in cfc.NMAP.board.get_all_cards():
			if card.card_name == card_name:
				unique_conflict = true
	return(unique_conflict)
