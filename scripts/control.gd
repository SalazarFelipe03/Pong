extends Node2D


@onready var mainMenu = $ui/mainMenu
@onready var gui      = $ui/gui
@onready var audio    = $ui/AudioStreamPlayer
@onready var paddle   = $paddle
@onready var paddle2  = $paddle2
@onready var ball     = $ball

func _process(_delta):
	gui.get_node("topBar").get_node("leftCounter").text = str(Global.left_score)
	gui.get_node("topBar").get_node("rightCounter").text = str(Global.right_score)
	gui.get_node("topBar").get_node("ballSpeed").text = str(Global.ballSpeed)
	if Input.is_action_just_pressed("ui_accept"):
		$Camera2D.apply_shake()

func game_start(single):
	mainMenu.visible = false
	gui.visible      = true
	paddle.enable    = true
	paddle2.enable   = !single
	paddle2.bot      = !paddle2.enable
	ball.enable      = true


func _on_exit_pressed():
	get_tree().quit()

func _on_pause_pressed():
	get_tree().paused = true
	$ui/pauseMenu.visible = true

func _on_unpaused_pressed():
	get_tree().paused = false
	$ui/pauseMenu.visible = false

func _on_reset_pressed():
	paddle.global_position.y = 252
	paddle2.global_position.y = 252
	ball.global_position = Vector2(572, 300)
	ball.speed = ball.INIT_SPEED
	ball.velocity = Vector2(-200, 0)
	Global.left_score = 0
	Global.right_score = 0


func _on_single_pressed():
	game_start(true)
	
func _on_multi_pressed():
	game_start(false)


func _on_ball_explotion_signal():
	
	$Camera2D.apply_shake()


func _on_exit_to_menu_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
