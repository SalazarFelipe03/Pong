extends Area2D

@export var enable       = true
@export var up           = "w"
@export var down         = "s"
@export var right_paddle = true
@export var bot          = false
var motion = 0.0
const ACC = 150.0
const MAXSPEED = 1000.0


func _process(delta):
	if enable:
		visible = true
		movement(delta)
	elif bot == true:
		visible = true
		botMovement(delta)
	else:
		visible=false
	
	#map limits
	self.global_position.y = clamp(global_position.y, 150, 572)


func _input(event):
	if (event is InputEventScreenTouch or event is InputEventScreenDrag) and !bot:
		if event.position.x > 574 and right_paddle == true:
			self.global_position.y = event.position.y
		if event.position.x < 574 and right_paddle == false:
			self.global_position.y = event.position.y
		
		self.global_position.y = clamp(global_position.y, 150, 572)

func movement(delta):
	if Input.is_action_pressed(up):
		motion -= ACC
	elif Input.is_action_pressed(down):
		motion += ACC
	else:
		motion = lerp(motion, 0.0, 10 * delta)
	
	
	motion=clamp(motion, -MAXSPEED, MAXSPEED)
	self.global_position.y += (motion) * delta

func botMovement(delta):
	var pos = self.global_position.y
	self.global_position.y = lerp(pos, Global.ballPos.y, 0.25)
