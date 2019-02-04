extends Area2D

const SPEED = 3
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
	position += movedir
	
	var explosion = RESOURCES.big_explosion.instance()
	for body in get_overlapping_bodies():
		if body.name == "Player":
			body.damage(DAMAGE)
			explosion.position = position
			get_node("/root/Game").add_child(explosion)
			queue_free()
		if not body.is_in_group("Enemy"):
			explosion.position = position
			get_node("/root/Game").add_child(explosion)
			queue_free()