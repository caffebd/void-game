extends Node2D

func _ready():
	$sound.play()

func _on_Button_pressed():
	$button.play()
	yield ($button, "finished")
	get_tree().change_scene("res://scenes/level.tscn")

