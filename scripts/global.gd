extends Node

var left_score = 0
var right_score = 0
var ballSpeed = 0
var ballPos   = Vector2(0,0)

func _process(delta):
	if Input.is_action_just_pressed("ui_select"):
		get_tree().reload_current_scene()
