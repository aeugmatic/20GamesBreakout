extends Control

# TODO:
# - implement option-locking for non-custom diffs
# - implement difficulties in the gameplay itself

func _ready() -> void:
	# Set "Easy" as the default difficulty setting
	$Panel/Options/DiffSelect/DiffButtonContainer/EasyCheckBox.button_pressed = true
	set_ui_diff_options()

func set_ui_diff_options() -> void:
	# Step 1: set the UI elements
	set_checkboxes()
	set_game_options() # Step 2: lock UI elements if non-custom difficulty

func set_checkboxes() -> void:
	for cb in $Panel/Options/DiffSelect/DiffButtonContainer.get_children():
		cb.button_pressed = false
	
	match Global.difficulty:
		"easy":
			$Panel/Options/DiffSelect/DiffButtonContainer/EasyCheckBox.button_pressed = true
		"medium":
			$Panel/Options/DiffSelect/DiffButtonContainer/MedCheckBox.button_pressed = true
		"hard":
			$Panel/Options/DiffSelect/DiffButtonContainer/HardCheckBox.button_pressed = true
		"custom":
			$Panel/Options/DiffSelect/DiffButtonContainer/CustomCheckBox.button_pressed = true

func set_game_options() -> void:
	# FIXME: tree could be re-organised to have this work with a for loop like with checkboxes
	if Global.difficulty != "custom":
		# for op in GameOptions.get_children():
		#     op/SettableUI = locked
		$Panel/Options/GameOptions/BallSpeedUpSelect/CheckButton.disabled = true
		$Panel/Options/GameOptions/PaddleShrinkSelect/CheckButton.disabled = true
	else:
		$Panel/Options/GameOptions/BallSpeedUpSelect/CheckButton.disabled = false
		$Panel/Options/GameOptions/PaddleShrinkSelect/CheckButton.disabled = false
	
	match Global.difficulty:
		"easy":
			$Panel/Options/GameOptions/BallSpeedUpSelect/CheckButton.button_pressed = false
			$Panel/Options/GameOptions/PaddleShrinkSelect/CheckButton.button_pressed = false
		"medium":
			$Panel/Options/GameOptions/BallSpeedUpSelect/CheckButton.button_pressed = true
			$Panel/Options/GameOptions/PaddleShrinkSelect/CheckButton.button_pressed = false
		"hard":
			$Panel/Options/GameOptions/BallSpeedUpSelect/CheckButton.button_pressed = true
			$Panel/Options/GameOptions/PaddleShrinkSelect/CheckButton.button_pressed = true

# Difficulty checkbox signals
func _on_easy_check_box_pressed() -> void:
	Global.set_difficulty("easy")
	set_ui_diff_options()

func _on_med_check_box_pressed() -> void:
	Global.set_difficulty("medium")
	set_ui_diff_options()

func _on_hard_check_box_pressed() -> void:
	Global.set_difficulty("hard")
	set_ui_diff_options()

func _on_custom_check_box_pressed() -> void:
	Global.set_difficulty("custom")
	set_ui_diff_options()

# Other signals
func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_game/game.tscn")

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
