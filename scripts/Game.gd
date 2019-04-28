extends Node2D

class_name Game

signal points_updated
signal lives_updated

export(int) var number_of_lives : int = 3
var points : int = 0
var blocks : Node2D

func _ready() -> void: 
	blocks = get_tree().get_root().find_node("Blocks", true, false)

func add_points(_points: int) -> void:
	points += _points
	emit_signal("points_updated", points)
	check_win_condition()
	
func lose_life() -> void:
	number_of_lives -= 1
	emit_signal("lives_updated", number_of_lives)
	
	if number_of_lives <= 0:
		end_game()
	else:
		var ball = get_tree().get_root().find_node("Ball", true, false)
		ball.spawn()
		
func end_game() -> void: 
	get_tree().change_scene("res://scenes/GameOver.tscn")
	print("Game has ended")

func check_win_condition() -> void:
	if blocks.get_children().size() <= 1:
		win_game()
		
func win_game() -> void: 
	var ball = get_tree().get_root().find_node("Ball", true, false)
	ball.queue_free()
	get_tree().change_scene("res://scenes/WinGame.tscn")
	print("Game has been won")