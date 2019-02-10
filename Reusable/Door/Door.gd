extends StaticBody2D

var state
var enemies_killed = 0
export (int) var total_enemies
enum states {OPEN, CLOSE}
export (bool) var health
export (int) var offset 
onready var player = get_parent().get_parent().get_parent().get_node("Player")

func _ready():
	if name == "Door8":
		change_state(OPEN)

func change_state(new_state):
	match new_state:
		OPEN:
			open()
		CLOSE:
			close()
	state = new_state

func _on_Initiate_body_entered(body):
	if enemies_killed != total_enemies and body.name == "Player":
		change_state(CLOSE)
		if name == "Door8":
			Music.stream = RESOURCES.final_boss_theme
			Music.volume_db = -6
			Music.play()

func _physics_process(delta):
	if enemies_killed == total_enemies:
		change_state(OPEN)

func close():
	$Sprite.play("Close")
	$noise.play()
	$CollisionShape2D.disabled = false

func open():
	$Sprite.play("Open")
	$CollisionShape2D.disabled = true
	if health == true and not $battery.unhealthy == true:
		$battery.show()
		$battery.healthy = true
	elif health == true and $battery.unhealthy == true:
		$battery.hide()

# DO NOT CROSS
# TERRIBLE SOLUTION AHEAD

func _on_SmallRoller_died():
	enemies_killed += 1

func _on_Turret_died():
	enemies_killed += 1

func _on_Turret2_died():
	enemies_killed += 1

func _on_SmallRoller4_died():
	enemies_killed += 1

func _on_SmallRoller3_died():
	enemies_killed += 1

func _on_Turret3_died():
	enemies_killed += 1

func _on_Turret6_died():
	enemies_killed += 1

func _on_Turret5_died():
	enemies_killed += 1

func _on_Turret4_died():
	enemies_killed += 1

func _on_SmallRoller5_died():
	enemies_killed += 1

func _on_SmallRoller6_died():
	enemies_killed += 1

func _on_SmallRoller7_died():
	enemies_killed += 1

func _on_SmallRoller8_died():
	enemies_killed += 1

func _on_Drone_dead():
	enemies_killed += 1

func _on_Drone2_dead():
	enemies_killed += 1

func _on_SmallRoller10_died():
	enemies_killed += 1

func _on_SmallRoller9_died():
	enemies_killed += 1

func _on_Turret7_died():
	enemies_killed += 1

func _on_Turret8_died():
	enemies_killed += 1

func _on_Drone3_dead():
	enemies_killed += 1

func _on_Turret9_died():
	enemies_killed += 1
