extends Control

@onready var audio = get_node("AudioStreamPlayer")
@onready var menuMove = preload("res://assets/sounds/menuMove.wav")
@onready var menuSelect = preload("res://assets/sounds/menuSelect.wav")

func _on_start_mouse_entered():
	audio.set_stream(menuMove)
	audio.play()
func _on_exit_mouse_entered():
	audio.set_stream(menuMove)
	audio.play()
func _on_single_mouse_entered():
	audio.set_stream(menuMove)
	audio.play()
func _on_multi_mouse_entered():
	audio.set_stream(menuMove)
	audio.play()


func _on_start_pressed():
	audio.set_stream(menuSelect)
	audio.play()
	$mainMenu/firstMenu.visible = false
	$mainMenu/playMenu.visible  = true


func _on_exit_pressed():
	audio.set_stream(menuSelect)
	audio.play()
	$mainMenu/firstMenu.visible = true
	$mainMenu/playMenu.visible = false
