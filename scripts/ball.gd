extends Area2D

@export var enable = true
@onready var audioPlayer = get_node("pingSound")
@onready var explotionSound = get_node("explotionSound")
@onready var particles   = get_node("flames")
@onready var explotion   = get_node("explotion")

var last_area
var velocity = Vector2(-400,0)
var hasColidedWithR = false
var speed = INIT_SPEED
const INIT_SPEED = 600
const ACC_INC = 40

signal explotionSignal


func _process(delta):
	#debug shenanigans
	Global.ballPos  = self.global_position
	Global.ballSpeed = speed
	
	# particles
	if speed >= 1000:
		particles.emitting = true
	else: particles.emitting = false
			
	if enable:
		self.visible = true
		movement(delta)
		score()
	else:
		visible = false

func movement(delta):
	self.position += velocity * delta
	if self.global_position.y >= 644 and velocity.y > 0:
		velocity.y *= -1
		audioPlayer.pitch_scale = 1
		audioPlayer.play()
	elif self.global_position.y <= 75 and velocity.y < 0:
		velocity.y *= -1
		audioPlayer.pitch_scale = 1
		audioPlayer.play()

func score():

	if self.global_position.x >= 1158:
		Global.left_score += 1
		speed = INIT_SPEED
		velocity = Vector2(-INIT_SPEED,0)
		self.global_position = Vector2(572, 300)
		last_area = null
	elif self.global_position.x <= 0:
		Global.right_score += 1
		speed = INIT_SPEED
		velocity = Vector2(INIT_SPEED, 0)
		self.global_position = Vector2(572, 300)
		last_area = null

func _on_area_entered(area):
	if area.is_in_group("paddle"):
		if area != last_area:
		
			last_area = area
			speed += ACC_INC
				
			
			#setting necesary variables
			var dir = sign(velocity.x)
			var paddle_center = area.global_position + Vector2(12,0)
			var ball_center   = self.global_position + Vector2(8,8)
			var area_rect = area.get_node("col").shape.get_rect().size
			
			#audio
			audioPlayer.pitch_scale = 1.1
			audioPlayer.play()
			
			#particles
			if particles.emitting == false and speed >= 1000:
				emit_signal("explotionSignal")
				explotionSound.play()
				explotion.global_position.y = ball_center.y
				explotion.direction.x = -dir
				explotion.emitting=true
				
				#double the speed
				speed += 80
			
			#defining new direction of the ball
			var angle  = (ball_center.y - paddle_center.y) * (PI / area_rect.y)
			angle = clamp(angle, -1, 1)
			var new_dir = Vector2(cos(angle), sin(angle))
			
			#applying new direction
			velocity = new_dir.normalized() * speed
			velocity.x *= -dir
