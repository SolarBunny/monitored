extends Area2D

const DAMAGE = 1
var anim

func _ready():
	anim = "down"

func _process(delta):
	if anim == "up":
		$AnimatedSprite.play("up")
		$CollisionShape2D.disabled = false
	elif anim == "down":
		$AnimatedSprite.play("down")
		$CollisionShape2D.disabled = true
	for body in get_overlapping_bodies():
		if body.name == "Player":
			body.damage(DAMAGE)

func _on_AnimatedSprite_animation_finished():
	if anim == "down":
		anim = "up"
	elif anim == "up":
		anim = "down"
