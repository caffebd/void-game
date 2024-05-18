extends Node2D

func _ready():
	GlobalVariables.player_oxygen = 100
	GlobalVariables.player_health = 100
	GlobalVariables.ammo = 10
	GlobalVariables.max_ammo = 20
	GlobalVariables.used_time = 0

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
		$FinishLine/endsound.play()
