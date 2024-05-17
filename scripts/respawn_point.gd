extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("stop_spawn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_respawn_point_body_entered(body):
	if body.is_in_group("player"):
		$AnimatedSprite.play("play_spawn")
		$res.play()
		GlobalSignal.emit_signal("respown_point",global_position)
		

