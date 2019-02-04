extends Control

var settings_open
var sound_mute

func _ready():
	settings_open = false
	$ButtonsContainer/Buttons/Start.grab_focus()
	var track = RESOURCES.main_theme
	Music.stream = track
	Music.play()
	$Fade.hide()

func _process(delta):
	if Music.music_mute == true:
		$Settings/VBoxContainer/Music.text = "Music: Off"
	elif Music.music_mute == false:
		$Settings/VBoxContainer/Music.text = "Music: On"
	if OS.window_fullscreen == true:
		$Settings/VBoxContainer/Fullscreen.text = "Fullscreen: On"
	else:
		$Settings/VBoxContainer/Fullscreen.text = "Fullscreen: Off"
	if sound_mute:
		$Settings/VBoxContainer/Sound.text = "Sound: Off"
		#AudioServer.set_bus_mute(1, true)
	elif !sound_mute:
		$Settings/VBoxContainer/Sound.text = "Sound: On"
		#AudioServer.set_bus_mute(1, false)
	

func _on_Start_pressed():
	$Fade.show()
	disable()
	$Fade/AnimationPlayer.play_backwards("Fade")

func _on_QUIT_pressed():
	get_tree().quit()

func _on_SETTINGS_pressed():
	if settings_open == false:
		$SettingsAnim.play("Appear")
		$Settings/VBoxContainer/Music.grab_focus()
		settings_open = true

func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://Game/Game.tscn")

func disable():
	$ButtonsContainer/Buttons/Start.disabled = true
	$ButtonsContainer/Buttons/Start.disabled = true
	$ButtonsContainer/Buttons/Start.disabled = true
	$Settings/VBoxContainer/Music.disabled = true
	$Settings/VBoxContainer/Fullscreen.disabled = true
	$Settings/VBoxContainer/Sound.disabled = true

func _on_Music_pressed():
	if Music.music_mute == true:
		Music.unmute()
	elif Music.music_mute == false:
		Music.mute()

func _on_Close_pressed():
	if settings_open:
		$SettingsAnim.play_backwards("Appear")
		$ButtonsContainer/Buttons/Start.grab_focus()
	settings_open = false

func _on_Sound_pressed():
	if not sound_mute:
		AudioServer.set_bus_mute(1, true)
		sound_mute = true
	elif sound_mute:
		AudioServer.set_bus_mute(1, false)
		sound_mute = false

func _on_Fullscreen_pressed():
	OS.window_fullscreen = !OS.window_fullscreen