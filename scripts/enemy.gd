extends KinematicBody2D


const GRAVITY = 900
export var walk_speed = 100

var direction = Vector2.ZERO

export var walk_time:float = 1

var movement = true

var food_scene = preload("res://scenes/food.tscn")

func _ready():
	$EnemyFoodSprite.play("enemy")
	$WalkTimer.wait_time = walk_time
	$WalkTimer.start()
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
		movement = false
		$EnemyCPUParticles.emitting = true
#		call_deferred("_disable_collision")
		var tween = create_tween()
		tween.tween_property($EnemyCPUParticles, "modulate:a", 0.0, 1.0)
		yield(tween, "finished")
		var food = food_scene.instance()
		get_parent().add_child(food)
		food.food_poss($EnemyFoodSprite.global_position)
		visible = false
#		GlobalSignal.emit_signal("food_poss", global_position)
#		$EnemyFoodSprite.play("food")
		_disable_collision()
		
	
func _disable_collision():
#	$KillArea/KillCollision.disabled = true
#	var tween2 = create_tween()
#	tween2.tween_property(self, $DieArea/DieCollision , "disabled" , true)
#	yield(tween2, "finished")
	queue_free()



