extends KinematicBody2D

export var speed = 250

export var jump_speed = -350

var gravity = 1200

var direction := Vector2.ZERO

var start_position = Vector2.ZERO

var bullet_scene = preload("res://scenes/bullet.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	start_position = global_position
	start_position.y -= 100
	print(start_position)
	GlobalSignal.connect("player_fell", self, "_player_fell")


func _player_fell():
	global_position = start_position
	print(global_position)

func _input(event):
	
	direction.x = 0
	
	if Input.is_action_just_pressed("attack"):
		
		var bullet = bullet_scene.instance()
		get_parent().add_child(bullet)
		bullet.shoot($attack_node/gunpos.global_position, Vector2($attack_node.scale.x,0))
		
	

	if Input.is_action_pressed("left"):
		direction.x -= speed
		$playeranim.flip_h = true
		$attack_node.scale.x = -1
		
		$playeranim.play("walk")
		
	elif Input.is_action_pressed("right"):
		direction.x += speed
		$playeranim.flip_h = false
		$attack_node.scale.x = 1
		
		
		$playeranim.play("walk")
	else:
		$playeranim.play("idle")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	direction.y += gravity/2 * delta
	
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			direction.y = jump_speed
	
	direction = move_and_slide(direction,  Vector2.UP)
	
	
