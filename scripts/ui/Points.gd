extends Label

onready var game : Game = $"/root/Game"

func _ready() -> void:
	game.connect("lives_updated", self, "on_lives_updated")
	text = str(game.number_of_lives)
	
func on_lives_updated(lives: int) -> void:
	text = str(lives)