extends Node

var player_died 
var explosion = RESOURCES.big_explosion.instance()
var added_child
var death_faded 

func _ready():
	$Fade.show()
	$Fade/AnimationPlayer.play("Fade")
	player_died = false
	added_child = false
	death_faded = false

func _on_PlayerDie_timeout():
	if not death_faded:
		$Fade/AnimationPlayer.play_backwards("Fade")
		death_faded = true

func _on_Player_died():
	if not added_child:
		explosion.position = get_node("Player").position
		add_child(explosion)
		added_child = true
		$PlayerDie.start()
		Music.mute()
	else:
		return
	player_died = true

func _on_AnimationPlayer_animation_finished(anim_name):
	if player_died:
		get_tree().change_scene("res://Title/Title.tscn")
