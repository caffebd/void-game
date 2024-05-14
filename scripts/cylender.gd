extends Area2D

export var oxy = 10
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_cylender_body_entered(body):
	if body.is_in_group("player"):
		GlobalVariables.player_oxygen += oxy
#		GlobalSignal.emit_signal("player_reset")
		print("collected")
		queue_free()
