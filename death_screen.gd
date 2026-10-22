extends CanvasLayer

const MENU_SCENE = "res://main_menu.tscn"

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()

	$VBoxContainer/RetryButton.pressed.connect(
		_on_retry_pressed
	)

func show_game_over() -> void:
	show()
	get_tree().paused = true

func _on_retry_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(MENU_SCENE)
