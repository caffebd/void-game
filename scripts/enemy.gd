extends KinematicBody2D


const GRAVITY = 900
export var food_hp = 10
export var walk_speed = 100

var direction = Vector2.ZERO

export var walk_time:float = 1

var movement = true

func _ready():
	$EnemyFoodSprite.play("enemy")
	$WalkTimer.wait_time = walk_time
	$WalkTimer.start()
	$Food/FoodCollision.disabled = true
#	$KillArea/KillCollision.disabled = false
	$DieArea/DieCollision.disabled = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if movement == true:
		direction.y += GRAVITY * delta
			
		if is_on_floor():
			direction.x = walk_speed
			
		direction = move_and_slide(direction, Vector2.UP)

func _on_WalkTimer_timeout():
	walk_speed *= -1



func _on_DieArea_body_entered(body):
	if body.is_in_group("player"):
		GlobalSignal.emit_signal("player_reset")
		
	elif body.is_in_group("ammo"):
		$EnemyCPUParticles.emitting = true
		call_deferred("_disable_collision")
		var tween = create_tween()
		tween.tween_property($EnemyCPUParticles, "modulate:a", 0.0, 1.0)
		movement = false
		$EnemyFoodSprite.play("food")
		yield(tween, "finished")
		call_deferred("_disable_collision")
		
	
func _disable_collision():
#	$KillArea/KillCollision.disabled = true
	$DieArea/DieCollision.disabled = true
	$Food/FoodCollision.disabled = false


func _on_Food_body_entered(body):
	if body.is_in_group("player"):
		GlobalVariables.player_health += food_hp
#		GlobalSignal.emit_signal("player_reset")
		print("collected")
		queue_free()
	
