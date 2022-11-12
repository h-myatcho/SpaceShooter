extends Control

func _ready():
	$VBoxContainer/StartButton.grab_focus()


func _on_StartButton_pressed():
	get_tree().change_scene("res://MainScenes/GamePlay.tscn")


func _on_ControlButton_pressed():
	get_tree().change_scene("res://Control.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()
