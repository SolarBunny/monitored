extends Node2D

signal died
onready var root = get_parent().get_parent()
var health = 7
var can_shoot

func _ready():
	can_shoot = false

func _process(delta):
	if health <= 0:
		die()

func shoot():
	if can_shoot:
		var bullet = RESOURCES.bullet.instance()
		bullet.position = $origin.global_position
		root.add_child(bullet)
		$Timer.start()
		if $Sprite.texture == RESOURCES.turret_2:
			$Sprite.texture = RESOURCES.turret_3

func _on_Timer_timeout():
	shoot()
	$Timer.start()

func _on_Initiate_body_entered(body):
	if body.name == "Player" and $Sprite.texture != RESOURCES.turret_3:
		can_shoot = true
		$Sprite.texture = RESOURCES.turret_2
		$Timer.start()

func damage(DAMAGE):
	$AnimationPlayer.play("damage")
	health -= DAMAGE

func die():
	var explosion = RESOURCES.big_explosion.instance()
	explosion.position = global_position
	get_node("../").add_child(explosion)
	emit_signal("died")
	queue_free()

func _on_VisibilityEnabler2D_screen_entered():
	can_shoot = true

func _on_VisibilityEnabler2D_screen_exited():
	can_shoot = false
