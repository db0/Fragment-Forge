# This class contains very custom scripts definitionsa for objects that need them
#
# The definition happens via object name
class_name CustomScripts
extends Reference

var costs_dry_run := false

func _init(_dry_run) -> void:
	costs_dry_run = _dry_run
# This fuction executes custom scripts
#
# It relies on the definition of each script being based the object's name
# Therefore the only thing we need, is the object itself to grab its name
# And to have a self-reference in case it affects itself
#
# You can pass a predefined subject, but it's optional.
func custom_script(script: ScriptTask) -> void:
	var owner = script.owner
	# warning-ignore:unused_variable
	var subjects: Array = script.subjects
	match script.owner.canonical_name:
		"All-Nighter":
			if not costs_dry_run:
				var cards_in_hand: int = cfc.NMAP.hand.get_card_count()
				var amount_to_draw: int =\
						cfc.NMAP.board.counters.get_counter(
						"motivation", owner) - cards_in_hand
				for _iter in range(amount_to_draw):
					cfc.NMAP.hand.draw_card()
					yield(owner.get_tree().create_timer(0.05), "timeout")
		"Refactoring":
			if not costs_dry_run:
				var discarded_shader: Card = script.subjects[0]
				var max_skill_req = discarded_shader.get_property("skill_req") + 1
				var hand_cards : Array = cfc.NMAP.hand.get_all_cards()
				var highest_time_shader: Card = null
				for shader in hand_cards:
					if shader.get_property("Type") == CardConfig.CardTypes.SHADER\
							and (not highest_time_shader
							or highest_time_shader.get_property("Time")
									< shader.get_property("Time"))\
							and shader.get_property("skill_req") <= max_skill_req:
						highest_time_shader = shader
				if highest_time_shader:
					highest_time_shader.move_to(cfc.NMAP.board)
