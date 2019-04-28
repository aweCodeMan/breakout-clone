extends KinematicBody2D

export(float) var speed : float = 200.0
var velocity : Vector2 = Vector2(0, 0)

var starting_position : Vector2
var starting_speed : float

onready var audio_player = $AudioStreamPlayer2D


func _ready() -> void:
	starting_position = position
	starting_speed = speed
	spawn()
	
func _physics_process(delta : float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.normal)
		.get_owner().get_node("Camera2D").start(0.1, 15, 3.5)
		increase_velocity()
		if collision.collider.has_method("hit"):
			collision.collider.hit()

func increase_velocity() -> void:
	speed += 0.015 * starting_speed
	velocity = velocity.normalized() * speed
	
func _on_VisibilityNotifier2D_screen_exited() -> void:
	var game = $"/root/Game"
	game.lose_life()

func spawn() -> void:
	randomize()
	position = starting_position
	speed = starting_speed
	velocity = Vector2(rand_range(-200, 200), rand_range(speed / 2, speed))
	velocity = velocity.normalized() * speed