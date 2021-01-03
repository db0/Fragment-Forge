extends Card

func _process(_delta: float) -> void:
	if cfc._debug and not get_parent().is_in_group("piles"):
		if properties.Type == CardConfig.CardTypes.SHADER:
			$Debug/ModifiedCost.text = "ModCost: "\
					+ str(get_skill_modified_shader_time_cost(
						properties.get("skill_req", 0),
						cfc.NMAP.board.counters.get_counter("skill"),
						properties.get("Time", 0)
					))

func check_play_costs() -> Color:
	var ret : Color = CFConst.CostsState.OK
	var time_cost = get_modified_time_cost()
	var kudos_cost = get_modified_kudos_cost()

	if time_cost > cfc.NMAP.board.counters.get_counter("time"):
		ret = CFConst.CostsState.IMPOSSIBLE
	elif time_cost > properties.get("Time", 0):
		ret = CFConst.CostsState.INCREASED
	elif time_cost < properties.get("Time", 0):
		ret = CFConst.CostsState.DECREASED

	if kudos_cost > cfc.NMAP.board.counters.get_counter("kudos"):
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
			cfc.NMAP.board.counters.get_counter("skill") \
			and properties.Type != CardConfig.CardTypes.SHADER:
		ret = CFConst.CostsState.IMPOSSIBLE

	if properties.get("cred_req", 0) > \
			cfc.NMAP.board.counters.get_counter("cred"):
		ret = CFConst.CostsState.IMPOSSIBLE

	if properties.get("motivation_req", 0) > \
			cfc.NMAP.board.counters.get_counter("motivation"):
		ret = CFConst.CostsState.IMPOSSIBLE
	return(ret)

func get_modified_time_cost() -> int:
	var modified_cost : int = properties.get("Time", 0)
	if properties.Type == CardConfig.CardTypes.SHADER:
		modified_cost = get_skill_modified_shader_time_cost(
				properties.get("skill_req", 0),
				get_altered_skill(),
				properties.get("Time", 0))
	return(modified_cost)

func get_modified_kudos_cost() -> int:
	var modified_cost : int = properties.get("Kudos", 0)
	return(modified_cost)

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

func common_move_scripts(new_container: Node, old_container: Node) -> void:
	if new_container == cfc.NMAP.board and old_container == cfc.NMAP.hand:
		pay_play_costs()
	if new_container == cfc.NMAP.hand \
			and old_container == cfc.NMAP.hand \
			and properties.Type == CardConfig.CardTypes.ACTION:
		# We don't pay the costs for Prep cards, as this is handled
		# in the common_pre_execution_scripts() method
		execute_scripts()

#func common_post_execution_scripts(trigger: String) -> void:
#	if trigger == "manual" and get_parent() == cfc.NMAP.hand:
#		# Prep cards automatically discard when played from hand
#		if properties.Type == CardConfig.CardTypes.ACTION:
#			pass
##			move_to(cfc.NMAP.discard)
#		# All other cards should not typically have a manual script from hand
#		# but instead be autoplayed when double-clicked
#		else:
#			var move_result = move_to(cfc.NMAP.board)
#			if move_result is GDScriptFunctionState: # Still working.
#				move_result = yield(move_result, "completed")

# Retrieves the card scripts either from those defined on the card
# itself, or from those defined in the script definition files
#
# Returns a dictionary of card scripts for this specific card
# based on the current trigger.
func retrieve_card_scripts(trigger: String) -> Dictionary:
	var found_scripts = .retrieve_card_scripts(trigger)
	if trigger == "manual" and get_state_exec() == "hand":
		found_scripts = insert_payment_costs(found_scripts)
		if properties.Type == CardConfig.CardTypes.ACTION:
			found_scripts["hand"] += generate_discard_action_tasks()
		else:
			found_scripts["hand"] += generate_install_tasks()
	return(found_scripts)
	
func insert_payment_costs(found_scripts) -> Dictionary:
	var array_with_costs := generate_play_costs_tasks()
	array_with_costs += found_scripts.get("hand",[])
	found_scripts["hand"] = array_with_costs
	return(found_scripts)
	
func pay_play_costs() -> void:
	var state_exec = get_state_exec()
	scripts["payments"] = {}
	scripts["payments"][state_exec] = generate_play_costs_tasks()
	execute_scripts(self,"payments")
	scripts["payments"].clear()
	
func generate_play_costs_tasks() -> Array:
	var payment_script_template := {
			"name": "mod_counter",
			"is_cost": true,
			"modification": 0,
			"tags": ["PlayCost"],
			"counter_name":  "counter"}
	var pay_tasks = []
	var time_cost = get_modified_time_cost()
	if time_cost:
		var cost_script = payment_script_template.duplicate()
		cost_script["modification"] = -time_cost
		cost_script["counter_name"] = "time"
		pay_tasks.append(cost_script)
	var kudos_cost = get_modified_kudos_cost()
	if kudos_cost:
		var cost_script = payment_script_template.duplicate()
		cost_script["modification"] = -kudos_cost
		cost_script["counter_name"] = "kudos"
		pay_tasks.append(cost_script)
	return(pay_tasks)
	
func generate_discard_action_tasks() -> Array:
	var discard_script_template := {
			"name": "move_card_to_container",
			"subject": "self",
			"dest_container": cfc.NMAP.discard}
	var discard_tasks = [discard_script_template]
	return(discard_tasks)
	
func generate_install_tasks() -> Array:
	var install_script_template := {
			"name": "move_card_to_board",
			"subject": "self",
			"is_cost": true,
			SP.KEY_GRID_NAME: mandatory_grid_name}
	var install_tasks = [install_script_template]
	return(install_tasks)

func get_altered_skill() -> int:
	var altered_skill : int = cfc.NMAP.board.counters.get_counter("skill")
	return(altered_skill)
