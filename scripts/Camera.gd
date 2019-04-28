extends Camera2D

const TRANS = Tween.TRANS_SINE
const EASE = Tween.EASE_IN_OUT

export(float) var shake_amplitude = 0

func start(duration = 0.2, frequency = 15, amplitude = 16)-> void:
	self.shake_amplitude = amplitude
	$Duration.wait_time = duration
	$Frequency.wait_time = 1 / float(frequency)
	$Duration.start()
	$Frequency.start()
	_shake()

func _shake() -> void:
	var rand = Vector2()
	rand.x = rand_range(-shake_amplitude, shake_amplitude)
	rand.y = rand_range(-shake_amplitude, shake_amplitude)
	
	var tween = $Tween
	tween.interpolate_property(self, 'offset', offset, rand, $Frequency.wait_time, TRANS, EASE)
	tween.start()

func _reset() -> void:
	var tween = $Tween
	tween.interpolate_property(self, 'offset', offset, Vector2.ZERO, $Frequency.wait_time, TRANS, EASE)
	tween.start()

func _on_Duration_timeout():
	_reset()
	$Frequency.stop()

func _on_Frequency_timeout():
	_shake()
