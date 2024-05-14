extends KinematicBody2D


export var move_to = Vector2.ZERO
export var move_time = 3.0

var start_pos = Vector2.ZERO
var target_pos = Vector2.ZERO

var direction = 1

func _ready():
	start_pos = global_position
	_begin_moving()


func _begin_moving():
	if direction == 1:
		target_pos = start_pos + move_to
	else:
		target_pos = start_pos
		
	var tween = create_tween()
	tween.tween_property(self, "global_position", target_pos, move_time)

	yield (tween, "finished")  
	direction *= -1
	
	_begin_moving()
