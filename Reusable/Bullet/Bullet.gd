extends KinematicBody2D

const SPEED = 2
const DAMAGE = 1 
var movedir = Vector2()
onready var player = get_node("../Player")
var dir = Vector2()

func _ready():
	dir = player.global_position - global_position
	rotation = dir.angle()
	$sound.play()

func _physics_process(delta):
	movedir = dir.normalized() * SPEED
	move_and_collide(movedir)

func _on_HitBox_body_entered(body):
	var explosion = preload("res://Reusable/Effects/Explosion.tscn").instance()
	if body.name == "Player":
		body.damage(DAMAGE)
		pass
	if not body.is_in_group("Enemy"):
		explosion.position = global_position
		get_parent().add_child(explosion)
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
