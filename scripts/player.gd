extends KinematicBody2D

export var speed = 250

export var jump_speed = -500

var gravity = 1200

var direction := Vector2.ZERO

var start_position = Vector2.ZERO

var bullet_scene = preload("res://scenes/bullet.tscn")

onready var coyote_timer = $CoyoteTimer

var shooting = true

var at_point = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalVariables.player_moving = true
	start_position = global_position
	$audio/BackgroundMusic.play()
	GlobalSignal.connect("player_fell", self, "_player_fell")
	GlobalSignal.connect("player_reset", self, "_player_reset")
	GlobalSignal.connect("respown_point",self, "_respown_point")
	GlobalSignal.connect("player_won", self, "_player_won")
	

func _player_won():
#	direction = Vector2.ZERO
	gravity = 0
#	global_position.y -= 100
	direction.y = -150
	$WinTimer.start()
	
#	call_deferred("_win_scene")
	
func _win_scene():
	get_tree().change_scene("res://scenes/win_scene.tscn")

func _respown_point(position):
#	at_point = true
	start_position = position

#
#func _collision_off():
#	$playercollision.disabled = true

func _player_reset():
	GlobalVariables.player_moving = false
	
#	if at_point == true:
	direction = Vector2.ZERO
	#$PortalSound.play()
	shooting = false
	#call_deferred("_collision_off")
	$CPUParticles2D.emitting = true
	$audio/respawn.play()
	
	var tween = create_tween()
	tween.tween_property($CPUParticles2D, "modulate:a", 0.0, 1.0)
	yield(tween, "finished")
	visible = false
	
	call_deferred("_spown")
#		global_position = start_position
	

func _spown():
	var tween2 = create_tween()
	tween2.tween_property(self, "global_position", start_position, 1.0)
	yield (tween2, "finished")
	GlobalVariables.player_health = 100
	GlobalVariables.player_oxygen = 100
	GlobalSignal.emit_signal("start_ui")
	visible = true
	shooting = true
	$CPUParticles2D.emitting = false
	$playercollision.disabled = false
	$audio/respawn.stop()
	$CPUParticles2D.modulate.a = 255
	GlobalVariables.player_moving = true
	



func _player_fell():
	global_position = start_position

func _input(event):
	
	if Input.is_action_just_pressed("attack") && shooting == true :
		if !GlobalVariables.ammo == 0:
			if GlobalVariables.ammo >= 0:
				GlobalVariables.ammo -= 1
				GlobalSignal.emit_signal("ammo_left")
				$audio/shooting.play()
	#			GlobalSignal.emit_signal("max_ammo_left")
				var bullet = bullet_scene.instance()
				get_parent().add_child(bullet)
				bullet.shoot($attack_node/gunpos.global_position, Vector2($attack_node.scale.x,0))
				
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	direction.x = 0
	direction.y += gravity * delta
	
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
#		$attack_node/Sprite.visible = false
	
	
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
	var is_grounded = $RayCastFloor.is_colliding() or  $RayCastFloor2.is_colliding()
	
	
	if Input.is_action_just_pressed("jump"):
		if GlobalVariables.player_moving == true:
			if is_grounded || !coyote_timer.is_stopped():
				$audio/jumping.play()
				direction.y = jump_speed
				GlobalSignal.emit_signal("start_ui")
	
	if is_grounded && !is_on_floor() :
		coyote_timer.start()
	
	direction = move_and_slide(direction,  Vector2.UP)
	

func _on_WinTimer_timeout():
	call_deferred("_win_scene")
