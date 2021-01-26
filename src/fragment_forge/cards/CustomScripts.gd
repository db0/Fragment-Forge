# This class contains very custom scripts definitionsa for objects that need them
#
# The definition happens via object name
class_name CustomScripts
extends Reference

var costs_dry_run := false

func _init(dry_run_req) -> void:
	costs_dry_run = dry_run_req
# This fuction executes custom scripts
#
# It relies on the definition of each script being based the object's name
# Therefore the only thing we need, is the object itself to grab its name
# And to have a self-reference in case it affects itself
#
# You can pass a predefined subject, but it's optional.
func custom_script(script: ScriptTask) -> void:
	var card: Card = script.owner_card
	var subjects: Array = script.subjects
	# I don't like the extra indent caused by this if, 
	# But not all object will be Card
	# So I can't be certain the "card_name" var will exist
	match script.owner_card.card_name:
		"Test Card 2":
			# No demo cost-based custom scripts
			if not costs_dry_run:
				print("This is a custom script execution.")
				print("Look! I am going to destroy myself now!")
				card.queue_free()
				print("You can do whatever you want here.")
		"Test Card 3":
			if not costs_dry_run:
				print("This custom script uses the _find_subject()"
						+ " to find a convenient target")
				print("Destroying: " + subjects[0].card_name)
				subjects[0].queue_free()
