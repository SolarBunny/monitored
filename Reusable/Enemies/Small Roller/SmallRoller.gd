extends KinematicBody2D

signal died
const SPEED = 65
const DAMAGE = 1
var movedir = Vector2()
onready var nav = get_parent().get_node("../Nav")
var move 
var health = 5
onready var player = get_parent().get_node("../Player")
const DAMAGE = 1

func _ready():
	move = false

func _physics_process(delta):
	if move == true:
		move()
		$AnimatedSprite.play("move")
		movedir = Vector2(-1, 0).rotated(global_position.angle_to_point(nav.get_closest_point(player.position))) * SPEED
	elif move == false:
		$AnimatedSprite.play("idle")
		movedir = Vector2(0, 0)
		
	if health <= 0:
		var explosion = RESOURCES.big_explosion.instance()
		explosion.position = global_position
		get_node("../").add_child(explosion)
		emit_signal("died")
		queue_free()

func move():
	if move == true:
		movedir = move_and_slide(movedir)
	elif move == false:
		movedir = Vector2(0, 0)

func _on_Move_body_entered(body):
	#if body.name == "Player":
		#move = true
		pass

func _on_Idle_body_exited(body):
	#if body.name == "Player":
		#move = false
		pass

func damage(DAMAGE):
	health -= DAMAGE
	$Anim.play("damage")

func _on_hitBox_body_entered(body):
	if body.name == "Player":
		body.damage(DAMAGE)

func _on_VisibilityEnabler2D_screen_exited():
	move = false

func _on_VisibilityEnabler2D_screen_entered():
	move = true