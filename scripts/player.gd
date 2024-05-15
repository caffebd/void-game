extends KinematicBody2D

export var speed = 250

export var jump_speed = -350

var gravity = 800

var direction := Vector2.ZERO

var start_position = Vector2.ZERO

var bullet_scene = preload("res://scenes/bullet.tscn")

var at_point = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalVariables.player_moving = true
	start_position = global_position
	
	print(start_position)
	GlobalSignal.connect("player_fell", self, "_player_fell")
	GlobalSignal.connect("player_reset", self, "_player_reset")
	GlobalSignal.connect("respown_point",self, "_respown_point")
	$HealthTimer.start()
	
func _respown_point(position):
#	at_point = true
	start_position = position

#
#func _collision_off():
#	$playercollision.disabled = true

func _player_reset():
	
#	if at_point == true:
	direction = Vector2.ZERO
	#$PortalSound.play()
	
	#call_deferred("_collision_off")
	$CPUParticles2D.emitting = true
	var tween = create_tween()
	tween.tween_property($CPUParticles2D, "modulate:a", 0.0, 1.0)
	yield(tween, "finished")
	GlobalVariables.player_moving = false
	visible = false
	call_deferred("_spown")
#		global_position = start_position
	

func _spown():
	var tween2 = create_tween()
	tween2.tween_property(self, "global_position", start_position, 1.0)
	yield (tween2, "finished")
	GlobalSignal.emit_signal("start_ui")
	visible = true
	$CPUParticles2D.emitting = false
	$playercollision.disabled = false
	GlobalVariables.player_moving = true



func _player_fell():
	global_position = start_position
	print(global_position)

func _input(event):
	
	if Input.is_action_just_pressed("attack"):
		if !GlobalVariables.ammo == 0:
			if GlobalVariables.ammo >= 0:
				GlobalVariables.ammo -= 1
				GlobalSignal.emit_signal("ammo_left")
	#			GlobalSignal.emit_signal("max_ammo_left")
				var bullet = bullet_scene.instance()
				get_parent().add_child(bullet)
				bullet.shoot($attack_node/gunpos.global_position, Vector2($attack_node.scale.x,0))
				
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	direction.x = 0
	direction.y += gravity/2 * delta
	
	if Input.is_action_pressed("left"):
		if GlobalVariables.player_moving == true:
			GlobalSignal.emit_signal("start_ui")
			direction.x -= speed
			$playeranim.flip_h = true
			$attack_node.scale.x = -1
			$playeranim.play("walk")
		
	elif Input.is_action_pressed("right"):
		if GlobalVariables.player_moving == true:
			GlobalSignal.emit_signal("start_ui")
			direction.x += speed
			$playeranim.flip_h = false
			$attack_node.scale.x = 1
			$playeranim.play("walk")
		
	else:
		$playeranim.play("idle")
		$attack_node/Sprite.visible = false
	
	
	if GlobalVariables.ammo == 0 && !GlobalVariables.max_ammo == 0:
		GlobalVariables.max_ammo -= 10
		GlobalVariables.ammo += 10
		GlobalSignal.emit_signal("ammo_left")
#		GlobalSignal.emit_signal("max_ammo_left")
#	if GlobalVariables.ammo == 0 && GlobalVariables.max_ammo == 0:
#		GlobalVariables.max_ammo = 0
#		GlobalVariables.ammo = 0
#		GlobalSignal.emit_signal("ammo_left")
#
#
#	if GlobalVariables.player_health == 0:
#		global_position = start_position
#		GlobalVariables.max_ammo = 20
#		GlobalVariables.ammo = 10
#
	var is_grounded = $RayCastFloor.is_colliding() 
	
	
	if Input.is_action_just_pressed("jump"):
		if is_grounded:
			direction.y = jump_speed
			GlobalSignal.emit_signal("start_ui")
	
	direction = move_and_slide(direction,  Vector2.UP)
	
