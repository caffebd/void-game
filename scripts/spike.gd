extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_spike_body_entered(body):
	if body.is_in_group("player"):
		GlobalSignal.emit_signal("player_reset")
		GlobalVariables.player_moving = false
		
