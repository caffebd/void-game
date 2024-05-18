extends Control


func _ready():
	$MenuSound.play()

func _on_PlayButton_pressed():
	$button.play()
	yield ($button, "finished")
	get_tree().change_scene("res://scenes/story.tscn")

	
