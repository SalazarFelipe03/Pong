extends Camera2D

var randomStrength:float = 30.0
var shakeFade:float = 5.0
var shakeStrength:float = 0.0
var rng = RandomNumberGenerator.new()

func _process(delta):
	
	if shakeStrength > 0:
		shakeStrength = lerpf(shakeStrength,0,shakeFade * delta)
		offset = random_offset()
		
func apply_shake():
	shakeStrength = randomStrength

func random_offset() -> Vector2:
	return Vector2(randf_range(-shakeStrength, shakeStrength), 0)
