extends KinematicBody2D

export(Vector2) var stretch_scale = Vector2(1.1, 0.95)

onready var tween = $Tween
onready var audio_player = $AudioStreamPlayer2D

var mouse_position : Vector2
var speed_for_full_stretch: float = 50.0

var hit_sound = preload("res://art/sounds/coin5.ogg")

func _ready() -> void:
	audio_player.stream = hit_sound
	
func hit() -> void:
	("HIT PADDLE")
	#audio_player.play(0)

func _physics_process(delta: float) -> void:
	if mouse_position == null:
		return
	
	var velocity = Vector2(mouse_position.x, position.y)
	velocity = velocity - position
	var collision = move_and_collide(velocity)
	
	var scale_factor = velocity_to_scale_factor(velocity)
	
	if collision:
		if collision.collider is StaticBody2D:
			scale_factor = Vector2.ONE
			
	$CollisionShape2D/Sprite.scale = scale_factor
	
func velocity_to_scale_factor(velocity: Vector2) -> Vector2:
	var factor : float = 1 - clamp(abs(velocity.x) / speed_for_full_stretch, 0.0, 1.0)
	var diff_x = stretch_scale.x - 1 * factor
	var diff_y = stretch_scale.y - 1 * factor
	return Vector2(1 + diff_x, 1 - diff_y)
	
func _input(event : InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_position = get_global_mouse_position()