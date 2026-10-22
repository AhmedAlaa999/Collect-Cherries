extends Camera2D

@export var scroll_speed: float = 40.0

func _process(delta: float) -> void:
	global_position.y -= scroll_speed * delta
