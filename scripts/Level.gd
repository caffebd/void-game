extends Node2D



func _on_fall_area_body_entered(body):
	if body.is_in_group("player"):
		GlobalSignal.emit_signal("player_fell")



func _on_finishing_area_body_entered(body):
	if body.is_in_group("player"):
		GlobalVariables.player_moving = false
		call_deferred("_player_up")
		
		

func _player_up():
	GlobalSignal.emit_signal("player_won")


func _on_Start_anim_body_entered(body):
	if body.is_in_group("player"):
		$FinishLine/FinishedParticles.emitting = true
