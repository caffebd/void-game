extends KinematicBody2D


var velocity = Vector2.ZERO

var speed = 300

func _ready():
	pass 

func shoot(pos, dir):
#	if GlobalVariables.ammo > 0 :
	global_position = pos
	scale.x = dir.x
	velocity = dir * speed
#		GlobalVariables.ammo -= 1
#		GlobalSignal.emit_signal("ammo_left")
#	if GlobalVariables.ammo == 0:
#		GlobalVariables.max_ammo -= 10
#		GlobalVariables.ammo += 10
#		GlobalSignal.emit_signal("ammo_left")
#		GlobalSignal.emit_signal("max_ammo_left")
#	elif GlobalVariables.max_ammo == 0:
#		print("No_ammo")
	
	

func _process(delta):
	var collided = move_and_collide(velocity * delta)
	if collided and collided.get_collider():
		if collided.get_collider().is_in_group("walls"):
#		var hit_object = collided.get_collider()
#		if hit_object.has_method("was_hit"):
#			hit_object.was_hit()
#		print(hit_object.name)
			queue_free()


