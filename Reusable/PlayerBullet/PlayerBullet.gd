extends Area2D

var movedir = Vector2(-1, 0)
const SPEED = 200
const DAMAGE = 1

func _process(delta):
	var explosion = RESOURCES.explosion.instance()
	explosion.position = global_position
	position += movedir.normalized() * SPEED * delta
	for body in get_overlapping_bodies():
		if body.is_in_group("Enemy"):
			body.damage(DAMAGE)
			pass
		if not body.name == "Player":
			get_node("../").add_child(explosion)
			queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
