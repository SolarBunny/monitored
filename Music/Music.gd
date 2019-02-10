extends AudioStreamPlayer

var music_mute = false

func _ready():
	volume_db = -5
	bus = "Music"

func mute():
	AudioServer.set_bus_mute(2, true)
	music_mute = true

func unmute():
	AudioServer.set_bus_mute(2, false)
	music_mute = false

func fade_out():
	volume_db = lerp(volume_db, -72, 0.05)

func stablize():
	volume_db = -6