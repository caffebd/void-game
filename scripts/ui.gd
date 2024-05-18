extends CanvasLayer
 

onready var health_bar = $MarginContainer/Row/TopRow/HealthSection/HealthBar
onready var current_ammo = $MarginContainer/Row/BottomRow/AmmoSection/CurrentAmmo
onready var max_ammo = $MarginContainer/Row/BottomRow/AmmoSection/MaxAmmo
onready var oxygen_bar = $MarginContainer/Row/TopRow/OxygenSection2/OxygenBar
onready var time_label = $MarginContainer/Row/TopRow/TimeSection/TimeLabel

var used_time = 0

var time = 20
var life
var oxy


func _ready():
	$MarginContainer/Timer.start()
	GlobalSignal.connect("ammo_left", self, "_ammo_left")
	GlobalSignal.connect("start_ui", self, "_start_ui")
	health_bar.value = GlobalVariables.player_health
	oxygen_bar.value = GlobalVariables.player_oxygen
	current_ammo.text = str(GlobalVariables.ammo)
	max_ammo.text = str(GlobalVariables.max_ammo)


func _start_ui():
	if GlobalVariables.player_moving == true:
		
		GlobalVariables.player_health -= life
		health_bar.value = GlobalVariables.player_health
		


	if GlobalVariables.player_health <= 0:
		GlobalVariables.player_moving = false
		GlobalVariables.player_health = 100
		GlobalVariables.player_oxygen = 100
		GlobalVariables.ammo = 10
		GlobalVariables.max_ammo = 20
		GlobalSignal.emit_signal("player_reset")
		current_ammo.text = str(GlobalVariables.ammo)
		max_ammo.text = str(GlobalVariables.max_ammo)
		health_bar.value = GlobalVariables.player_health
		oxygen_bar.value = GlobalVariables.player_oxygen
		
		
	
	
	



func _ammo_left():
	current_ammo.text = str(GlobalVariables.ammo)
	max_ammo.text = str(GlobalVariables.max_ammo)


#if GlobalVariables.ammo == 0 && GlobalVariables.max_ammo == 0:
#		GlobalVariables.max_ammo = 0
#		GlobalVariables.ammo = 0
#		GlobalSignal.emit_signal("ammo_left")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	life = time * delta/4
	oxy = time * delta/6
	
	GlobalVariables.player_oxygen -= oxy
	
	health_bar.value = GlobalVariables.player_health
	oxygen_bar.value = GlobalVariables.player_oxygen
	current_ammo.text = str(GlobalVariables.ammo)
	max_ammo.text = str(GlobalVariables.max_ammo)
	
	if GlobalVariables.player_oxygen <= 0:
		GlobalVariables.player_moving = false
		GlobalVariables.player_oxygen = 100
		GlobalVariables.player_health = 100
		GlobalVariables.ammo = 10
		GlobalVariables.max_ammo = 20
		GlobalSignal.emit_signal("player_reset")
		current_ammo.text = str(GlobalVariables.ammo)
		max_ammo.text = str(GlobalVariables.max_ammo)
		health_bar.value = GlobalVariables.player_health
		oxygen_bar.value = GlobalVariables.player_oxygen
#	if player_moving == true:
#		var life = time * delta/1
#		GlobalVariables.player_health -= life
#		health_bar.value = GlobalVariables.player_health
#
#		var oxy = time * delta/9
#		GlobalVariables.player_oxygen -= oxy
#		oxygen_bar.value = GlobalVariables.player_oxygen
#
#	print(GlobalVariables.player_oxygen)
#
#	if GlobalVariables.player_health <= 0:
#		GlobalVariables.player_health = 100
#		GlobalVariables.player_oxygen = 100
#		GlobalVariables.ammo = 10
#		GlobalVariables.max_ammo = 20
#		current_ammo.text = str(GlobalVariables.ammo)
#		max_ammo.text = str(GlobalVariables.max_ammo)
#		GlobalSignal.emit_signal("player_reset")
#
#	elif GlobalVariables.player_oxygen <= 0:
#		GlobalVariables.player_oxygen = 100
#		GlobalVariables.player_health = 100
#		GlobalVariables.ammo = 10
#		GlobalVariables.max_ammo = 20
#		current_ammo.text = str(GlobalVariables.ammo)
#		max_ammo.text = str(GlobalVariables.max_ammo)
#		GlobalSignal.emit_signal("player_reset")
#	print(GlobalVariables.player_health)
	




func _on_Timer_timeout():
	GlobalVariables.used_time += 1
	time_label.text = "Time : " + str(GlobalVariables.used_time)
	
