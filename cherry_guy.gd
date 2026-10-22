extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0
const DEATH_MARGIN = 30.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sound: AudioStreamPlayer = $JumpSound

var is_dead: bool = false

func _physics_process(delta: float) -> void:
	if is_dead:
		return

	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction := Input.get_axis("ui_left", "ui_right")

	if direction != 0:
		velocity.x = direction * SPEED
		animated_sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sound.play()

	move_and_slide()

	if not is_on_floor():
		animated_sprite.play("Jump")
	elif direction != 0:
		animated_sprite.play("Run")
	else:
		animated_sprite.play("Ideal")


func _process(_delta: float) -> void:
	if is_dead:
		return

	var camera := get_viewport().get_camera_2d()

	if camera == null:
		return

	var screen_bottom: float = camera.global_position.y + (
		get_viewport_rect().size.y / (2.0 * camera.zoom.y)
	)

	if global_position.y > screen_bottom + DEATH_MARGIN:
		die()

func die() -> void:
	if is_dead:
		return

	is_dead = true
	velocity = Vector2.ZERO
	set_physics_process(false)

	var death_screen = get_node_or_null("../DeathScreen")

	if death_screen != null:
		death_screen.show_game_over()
