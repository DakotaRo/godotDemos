extends ColorRect

@onready var playButton: Button = find_child("Button2")
@onready var quitButton: Button = find_child("Button")

func _ready() -> void:
	playButton.pressed.connect(unpause)
	quitButton.pressed.connect(get_tree().quit)

func unpause():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func pause():
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
