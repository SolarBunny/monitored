extends Area2D

var movedir = Vector2()
onready var player = get_node("../Player")
const SPEED = 3.5

func _ready():
	$Timer.start()

func _process(delta):
	var dir = null # player's position 

func _on_Timer_timeout():
	die()

func die():
	var explosion = RESOURCES.big_explosion.instance()
	explosion.position = self.position
	get_node("..").add_child(explosion)
	queue_free()