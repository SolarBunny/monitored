extends Node

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://Title/Title.tscn")
