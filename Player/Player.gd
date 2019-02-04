extends KinematicBody2D

signal damaged
signal died
const SPEED = 95
const WALL = Vector2(0, 0)
var movedir = Vector2()
var can_shoot
var invincible = false
var health = 6
export (bool) var immortal
onready var cam = get_node("../Camera2D")
var dead

func _ready():
	can_shoot = true
	health = 6
	dead = false

func _physics_process(delta):
	var global_pos = global_position
	controls_loop()
	movement()
	animation()
	if health <= 0 and not immortal:
		die()

func movement():
	if not dead:
		var motion = movedir.normalized() * SPEED
		move_and_slide(motion, WALL)

func controls_loop():
	
	var up = Input.is_action_pressed("w")
	var right = Input.is_action_pressed("d")
	var left = Input.is_action_pressed("a")
	var down =Input.is_action_pressed("s")
	
	movedir.x = -int(left) + int(right)
	movedir.y = -int(up) + int(down)
	
	if Input.is_action_pressed("ui_up"):
		shoot(Vector2(0, -1))
	if Input.is_action_pressed("ui_left"):
		shoot(Vector2(-1, 0))
	if Input.is_action_pressed("ui_down"):
		shoot(Vector2(0, 1))
	if Input.is_action_pressed("ui_right"):
		shoot(Vector2(1, 0))

func animation():
	if movedir != Vector2(0, 0):
		$Sprite.play("walk")
		$Trail.emitting = true
	else:
		$Sprite.play("idle")
		$Trail.emitting = false

func shoot(dir):
	if can_shoot:
		var bullet = RESOURCES.player_bullet.instance()
		get_node("../").add_child(bullet)
		bullet.position = position 
		bullet.movedir = dir
		$ShootTimer.start()
		can_shoot = false
	else:
		return

func _on_ShootTimer_timeout():
	can_shoot = true

func damage(damage):
	if not invincible:
		health -= damage
		$hurt.play()
		$anim.play("Damaged")
		invincible = true
		emit_signal("damaged", health)

func _on_anim_animation_finished(anim_name):
	if anim_name == "Damaged":
		invincible = false

func die():
	dead = true
	emit_signal("died")
	hide()
	$CollisionShape2D.disabled = true
	