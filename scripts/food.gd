extends KinematicBody2D

export var food_hp = 30

onready var collectingSound = $pickup

var velocity = Vector2.ZERO
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#
#export(NodePath) var linked_enemy_path
#onready var linked_enemy = get_node(linked_enemy_path)

# Called when the node enters the scene tree for the first time.
#func _ready():
#	GlobalSignal.connect("food_poss", self, "_food_poss")
##	var crystal_count = linked_enemy.get_child(position)
#
func food_poss(pos):
	global_position = pos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		GlobalVariables.player_health += food_hp
		collectingSound.play()
		visible = false
		yield(collectingSound, "finished")
#		GlobalSignal.emit_signal("player_reset")
		print("collected")
		queue_free()
