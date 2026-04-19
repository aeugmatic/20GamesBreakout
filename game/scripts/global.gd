extends Node

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

var music_vol: float = 50.0
var sfx_vol: float = 50.0
var difficulty: String = "easy"
var game_settings: Dictionary = DIFF_SETTINGS[difficulty] # Easy as default difficulty

func set_difficulty(diff: String) -> void:
	difficulty = diff
	if difficulty != "custom":
		game_settings = DIFF_SETTINGS[diff]
	
	print("Global:")
	print(game_settings)
