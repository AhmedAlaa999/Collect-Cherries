extends Node2D

const COINS_TO_WIN = 10
var coins_collected: int = 0

@onready var coin_label: Label = $HUD/CoinLabel
@onready var victory_screen: CanvasLayer = $VictoryScreen

func _ready() -> void:
	coin_label.text = "Coins: 0/%d" % COINS_TO_WIN

func add_coin() -> void:
	if coins_collected >= COINS_TO_WIN:
		return

	coins_collected += 1
	coin_label.text = "Coins: %d/%d" % [
		coins_collected,
		COINS_TO_WIN
	]

	if coins_collected >= COINS_TO_WIN:
		victory_screen.show_victory()
