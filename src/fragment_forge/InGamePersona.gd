# Holds the info about the persona assigned to this deck
# Also responsible for triggering manual scripts from this persona
class_name InGamePersona
extends HBoxContainer

# The persona resource
var persona: Persona
var _debugger_hook := false
var canonical_name: String

# Called when the deck is first loaded, to populate the various fields
# and textures
func setup() -> void:
	if ffc.current_persona:
		persona = ffc.current_persona
		$Persona.icon = persona.persona_art
		$VBC/PersonaName.text = persona.persona_name
		canonical_name = persona.persona_name
		$VBC/PersonaAbilities.text = persona.ability
	else:
		$Persona.icon = Persona.get_undecided_texture()
		$VBC/PersonaName.text = "Persona not defined!"
		$VBC/PersonaAbilities.text = "N/A"
		canonical_name = ''
	

# Executes the tasks defined in the persona's scripts in order.
#
# Returns a [ScriptingEngine] object but that it not statically typed
# As it causes the parser think there's a cyclic dependency.
func execute_scripts(
		trigger_card: Card = null,
		trigger: String = "manual",
		trigger_details: Dictionary = {},
		only_cost_check := false):
	if cfc.game_paused or $Persona.disabled:
		return
	var scripts : Dictionary = retrieve_scripts(trigger)
	# We check the trigger against the filter defined
	# If it does not match, then we don't pass any scripts for this trigger.
	if not SP.filter_trigger(
			scripts,
			trigger_card,
			self,
			trigger_details):
		scripts.clear()
	var state_scripts = []
	# We select which scripts to run from the card, based on it state
	var state_exec := 'persona'
	state_scripts = scripts.get(state_exec, [])
	# Here we check for confirmation of optional trigger effects
	# There should be an SP.KEY_IS_OPTIONAL definition per state
	# E.g. if board scripts are optional, but hand scripts are not
	# Then you'd include an "is_optional_board" key at the same level as "board"
	var confirm_return = CFUtils.confirm(
		scripts,
		persona.persona_name,
		trigger,
		state_exec)
	if confirm_return is GDScriptFunctionState: # Still working.
		confirm_return = yield(confirm_return, "completed")
		# If the player chooses not to play an optional cost
		# We consider the whole cost dry run unsuccesful
		if not confirm_return:
			state_scripts = []

	# If the state_scripts return a dictionary entry
	# it means it's a multiple choice between two scripts
	if typeof(state_scripts) == TYPE_DICTIONARY:
		var choices_menu = Card._CARD_CHOICES_SCENE.instance()
		choices_menu.prep(self.card_name,state_scripts)
		# We have to wait until the player has finished selecting an option
		yield(choices_menu,"id_pressed")
		# If the player just closed the pop-up without choosing
		# an option, we don't execute anything
		if choices_menu.id_selected:
			state_scripts = state_scripts[choices_menu.selected_key]
		else: state_scripts = []
		# Garbage cleanup
		choices_menu.queue_free()
	# To avoid unnecessary operations
	# we evoke the ScriptingEngine only if we have something to execute
	var sceng = null
	if len(state_scripts):
		if persona.scripts_frequency != "always":
			$Persona.disabled = true
		# This evocation of the ScriptingEngine, checks the card for
		# cost-defined tasks, and performs a dry-run on them
		# to ascertain whether they can all be paid,
		# before executing the card script.
		sceng = cfc.scripting_engine.new(
				state_scripts,
				self,
				trigger_card,
				trigger_details)
		# In case the script involves targetting, we need to wait on further
		# execution until targetting has completed
		sceng.execute(CFInt.RunType.COST_CHECK)
		if not sceng.all_tasks_completed:
			yield(sceng,"tasks_completed")
		# If the dry-run of the ScriptingEngine returns that all
		# costs can be paid, then we proceed with the actual run
		if sceng.can_all_costs_be_paid and not only_cost_check:
			#print("DEBUG:" + str(state_scripts))
			# The ScriptingEngine is where we execute the scripts
			# We cannot use its class reference,
			# as it causes a cyclic reference error when parsing
			sceng.execute()
			if not sceng.all_tasks_completed:
				yield(sceng,"tasks_completed")
		# This will only trigger when costs could not be paid, and will
		# execute the "is_else" tasks
		elif not sceng.can_all_costs_be_paid and not only_cost_check:
			#print("DEBUG:" + str(state_scripts))
			sceng.execute(CFInt.RunType.ELSE)
	return(sceng)


func _on_Persona_pressed() -> void:
	execute_scripts()

# Connects to the next-competition button
# re-enables personas which are once-per-competition
func _on_Start_pressed() -> void:
	if persona.scripts_frequency == "once_per_competition":
		$Persona.disabled = false

# This allows us to not trigger alterants when the button is disabled
# by sending a state which will never have any scripts for alterants
func get_state_exec() -> String:
	if not $Persona.disabled:
		return("persona")
	else:
		return("disabled")

func retrieve_scripts(trigger: String) -> Dictionary:
	var found_scripts: Dictionary
	found_scripts = persona.scripts.get(trigger, {}).duplicate()
	return(found_scripts)
