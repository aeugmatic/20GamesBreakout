extends Control

func _ready() -> void:
	# Set music slider
	$OptionsPanel/Sliders/MusicSlider/HSlider.value = Global.music_vol
	$OptionsPanel/Sliders/MusicSlider/ValueLabel.text = str(int(Global.music_vol)) + "%"
	
	# Set SFX slider
	$OptionsPanel/Sliders/SFXSlider/HSlider.value = Global.sfx_vol
	$OptionsPanel/Sliders/SFXSlider/ValueLabel.text = str(int(Global.sfx_vol)) + "%"

func _on_music_slider_value_changed(value: float) -> void:
	Global.music_vol = value
	$OptionsPanel/Sliders/MusicSlider/ValueLabel.text = str(int(value)) + "%"

func _on_sfx_slider_value_changed(value: float) -> void:
	Global.sfx_vol = value
	$OptionsPanel/Sliders/SFXSlider/ValueLabel.text = str(int(value)) + "%"

func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
