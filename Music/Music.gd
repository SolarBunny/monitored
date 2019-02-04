extends AudioStreamPlayer

var music_mute = false

func _ready():
	volume_db = -6

func mute():
	stop()
	music_mute = true

func unmute():
	play()
	music_mute = false
