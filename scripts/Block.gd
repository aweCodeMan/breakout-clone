extends StaticBody2D

export(int) var number_of_hits : int = 1
export(int) var points = 100

export(Vector2) var starting_scale = Vector2(0.75, 0.75)
export(Vector2) var ending_scale = Vector2(1, 1)


onready var game = $"/root/Game"
onready var collision_shape = $CollisionShape2D
onready var image = $CollisionShape2D/NinePatchRect
onready var tween = $Tween
onready var animation_player = $AnimationPlayer
onready var audio_player = $AudioStreamPlayer2D

var hit_sound = preload("res://art/sounds/coin2.ogg")

var hits : int = 0

func _ready() -> void:
	audio_player.stream = hit_sound

func hit() -> void:
	hits += 1	
	
	#audio_player.play(0)
	collision_shape.disabled = true
	tween.interpolate_property(image, 'rect_scale', starting_scale, ending_scale, 0.20, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	tween.start()
	animation_player.play("hit_color")
	yield(tween, 'tween_completed')
	
	if hits >= number_of_hits:
		break_block()
		self.queue_free()
	
	collision_shape.disabled = false
	
		
func break_block() -> void:
	game.add_points(points)
	self.queue_free()
	