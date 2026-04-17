extends Control

const DIFF_SETTINGS: Dictionary = {
	"easy": {
		"ball-speedup": false,
		"paddle_shrink": false
	},
	"medium": {
		"ball-speedup": true,
		"paddle_shrink": false
	},
	"hard": {
		"ball-speedup": true,
		"paddle_shrink": true
	}
}

# 
# TODO:
# - implement option-locking for non-custom diffs
# - implement difficulties in the gameplay itself

func _ready() -> void:
	# Set "Easy" as the default difficulty setting
	$Panel/Options/DiffSelect/DiffButtonContainer/EasyCheckBox.button_pressed = true

func set_options_based_on_diff(diff: String) -> void:
	Global.game_settings[diff] = DIFF_SETTINGS[diff]
