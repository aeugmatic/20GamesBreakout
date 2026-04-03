extends Control

func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_game/game.tscn")

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/option_menu.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
