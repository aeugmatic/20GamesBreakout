extends Control

func set_score_values(score: int) -> void:
	$MainPanel/ResultPanel/Score/ValueLabel.text = str(score)
	$MainPanel/ResultPanel/HighScore/ValueLabel.text = str(Global.high_score)

# 
# TODO: find a way to do the "paused = false" thing better - doesn't
# feel right for the GameOverMenu to handle this rather than the Game
# scene
# 
func _on_new_game_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menus/game_setup_menu.tscn")

func _on_exit_to_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
