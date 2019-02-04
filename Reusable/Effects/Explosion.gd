extends Particles2D

func _ready():
	emitting = true
	$explodesound.play()

func _on_Timer_timeout():
	queue_free()
