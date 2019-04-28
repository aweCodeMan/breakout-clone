extends Label

onready var game : Game = $"/root/Game"

func _ready() -> void:
	game.connect("points_updated", self, "on_points_updated")
	text = str(game.points)
	
func on_points_updated(points: int) -> void:
	text = str(points)