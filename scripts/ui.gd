extends CanvasLayer
 

onready var health_bar = $MarginContainer/Row/TopRow/HealthSection/HealthBar
onready var current_ammo = $MarginContainer/Row/BottomRow/AmmoSection/CurrentAmmo
onready var max_ammo = $MarginContainer/Row/BottomRow/AmmoSection/MaxAmmo
onready var oxygen_bar = $MarginContainer/Row/TopRow/OxygenSection2/OxygenBar

var time = 20

var player_moving = false

func _ready():
	player_moving = false
	GlobalSignal.connect("ammo_left", self, "_ammo_left")
	GlobalSignal.connect("start_ui", self, "_start_ui")
	health_bar.value = GlobalVariables.player_health
	oxygen_bar.value = GlobalVariables.player_oxygen
	current_ammo.text = str(GlobalVariables.ammo)
	max_ammo.text = str(GlobalVariables.max_ammo)


func _start_ui():
	player_moving = true
	


func _ammo_left():
	current_ammo.text = str(GlobalVariables.ammo)
	max_ammo.text = str(GlobalVariables.max_ammo)


#if GlobalVariables.ammo == 0 && GlobalVariables.max_ammo == 0:
#		GlobalVariables.max_ammo = 0
#		GlobalVariables.ammo = 0
#		GlobalSignal.emit_signal("ammo_left")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player_moving == true:
		var life = time * delta/1
		GlobalVariables.player_health -= life
		health_bar.value = GlobalVariables.player_health
		
		var oxy = time * delta/9
		GlobalVariables.player_oxygen -= oxy
		oxygen_bar.value = GlobalVariables.player_oxygen
	
	print(GlobalVariables.player_oxygen)

	if GlobalVariables.player_health <= 0:
		GlobalVariables.player_health = 100
		GlobalVariables.player_oxygen = 100
		GlobalVariables.ammo = 10
		GlobalVariables.max_ammo = 20
		current_ammo.text = str(GlobalVariables.ammo)
		max_ammo.text = str(GlobalVariables.max_ammo)
		GlobalSignal.emit_signal("player_reset")
		
	elif GlobalVariables.player_oxygen <= 0:
		GlobalVariables.player_oxygen = 100
		GlobalVariables.player_health = 100
		GlobalVariables.ammo = 10
		GlobalVariables.max_ammo = 20
		current_ammo.text = str(GlobalVariables.ammo)
		max_ammo.text = str(GlobalVariables.max_ammo)
		GlobalSignal.emit_signal("player_reset")
	print(GlobalVariables.player_health)
	



