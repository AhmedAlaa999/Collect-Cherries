extends Area2D

@onready var collect_sound: AudioStreamPlayer = $AudioStreamPlayer

var collected := false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if collected or body.name != "CherryGuy":
		return

	collected = true
	set_deferred("monitoring", false)

	var main_map = get_tree().current_scene
	main_map.add_coin()

	var sound_player := AudioStreamPlayer.new()
	sound_player.stream = collect_sound.stream
	get_tree().root.add_child(sound_player)
	sound_player.finished.connect(sound_player.queue_free)
	sound_player.play()

	hide()
	queue_free()
