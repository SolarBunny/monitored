extends StaticBody2D

var state
var enemies_killed = 0
export (int) var total_enemies
enum states {OPEN, CLOSE}

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

func _physics_process(delta):
	if enemies_killed == total_enemies:
		change_state(OPEN)

func close():
	$Sprite.play("Close")
	$CollisionShape2D.disabled = false

func open():
	$Sprite.play("Open")
	$CollisionShape2D.disabled = true

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