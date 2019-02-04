extends KinematicBody2D

var movedir = Vector2()
var move
var can_shoot
var health = 6
onready var nav = get_parent().get_node("../Nav")
onready var player = get_parent().get_node("../Player")
onready var root = get_parent().get_parent()
const SPEED = 50

func _ready():
	move = false
	can_shoot = false
	$Sheild/SheildAnim.play("spin")

func _physics_process(delta):
	if move == true:
		move_and_slide(movedir)
		movedir = Vector2(-1, 0).rotated(global_position.angle_to_point(nav.get_closest_point(player.position))) * SPEED
	else:
		movedir = Vector2(0, 0)
	if can_shoot == false:
		$Sheild.show()
	elif not can_shoot:
		$Sheild.hide()
	if health <= 0:
		var explosion = RESOURCES.big_explosion.instance()
		explosion.position = position
		root.add_child(explosion)
		queue_free()
		pass

func _on_VisibilityEnabler2D_screen_entered():
	can_shoot = true
	move = true
	$Shoot.start()

func _on_VisibilityEnabler2D_screen_exited():
	move = false
	can_shoot = false

func _on_Shoot_timeout():
	shoot()
	can_shoot = true
	pass
	
func shoot():
	if can_shoot:
		$Sheild.hide()
		var bullet = RESOURCES.sheildbullet.instance()
		bullet.position = $origin.global_position
		root.add_child(bullet)
		$Restore.start()
		$Sheild/CollisionShape2D.disabled = true
		$Sheild/CollisionShape2D2.disabled = true
		can_shoot = false

func damage(DAMAGE):
	health -= DAMAGE
	$Effect.play("DamageFlash")

func _on_Restore_timeout():
	$Sheild.show()
	$Shoot.start()
	$Sheild/CollisionShape2D.disabled = false
	$Sheild/CollisionShape2D2.disabled = false