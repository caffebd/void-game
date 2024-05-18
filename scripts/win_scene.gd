extends Node2D

var direction := Vector2.ZERO

var start_pos = Vector2.ZERO
var target_pos = Vector2.ZERO
export var move_to = Vector2.ZERO
var scaling = Vector2.ZERO


func _ready():
	$sound.play()
	$After_anim.visible = false
	start_pos = global_position
	_start_moving()
#	pass
func _process(delta):
	pass
	
	
func _start_moving():
	target_pos = start_pos + move_to
	
#	direction.y = 340
#	direction.x = 750
#
#	global_position.x = 750
#	global_position.y = 340
#	var new_poss = global_position
	var mship = $Ship_Anim
	var tween = create_tween()
	tween.tween_property(mship, "global_position", target_pos, 3.0)
	
	var tween2 = create_tween()
	tween2.tween_property(mship, "scale", scaling, 3.0)
	yield (tween2, "finished")
	$After_anim/Time.text = "Beat your own time : " + str(GlobalVariables.used_time)
	$After_anim.visible = true
	


func _on_Button_pressed():
	get_tree().change_scene("res://scenes/level.tscn")
