extends DBGridCardObject


func _on_DBGridCardObject_mouse_entered() -> void:
	if cfc.game_settings.animate_in_deckbuilder_preview:
		preview_popup.show_preview_card(display_card.canonical_name)

func _on_DBGridCardObject_mouse_exited() -> void:
	if cfc.game_settings.animate_in_deckbuilder_preview:
		preview_popup.hide_preview_card()
