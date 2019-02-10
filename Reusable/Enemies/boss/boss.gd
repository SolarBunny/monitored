extends StaticBody2D

enum states{IDLE, ALERTED, LASER, BULLETS}
var state
var attacking
var attacks = [BULLETS, LASER]

func _ready():
	change_state(IDLE)
	attacking = false
	
func change_state(new_state):
	match new_state:
		IDLE:
			$AnimatedSprite.play("default")
			attacking = false
			# startup
		ALERTED:
			$AnimatedSprite.play("Alerted")
			attacking = false
			$AlertedTimer.start()
			# a few seconds after player walks in
		LASER:
			$AnimatedSprite.play("Lasers")
			attacking = true
			# intersecting lines that rotate
		BULLETS:
			$AnimatedSprite.play("Missles")
			# bullets that follow player and explode
			attacking = true
	state = new_state

func _process(delta):
	# switcheroo states or whatever
	pass

func _on_Initiate_body_entered(body):
	if body.name == "Player":
		$IdleTimer.start()

func _on_IdleTimer_timeout():
	change_state(ALERTED)

func _on_AlertedTimer_timeout():
	attack()

func attack():
	var attack = randi() % attacks.size()
	match attack:
		0:
			change_state(BULLETS)
		1:
			change_state(LASER)