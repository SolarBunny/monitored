extends Area2D

var healthy
var unhealthy

func _ready():
	healthy = false
	unhealthy = false
	hide()

func _process(delta):
	for body in get_overlapping_bodies():
		if body.name == "Player" and healthy:
			body.restore()
			healthy = false
			hide()
			$noise.play()
			unhealthy = true
	if not healthy:
		hide()
