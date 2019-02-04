extends Camera2D

func _process(delta):
	var player = get_node("../Player").global_position - Vector2(0, 16)
	var x = floor(player.x/480) * 480
	var y = floor(player.y/270) * 270
	var posx = global_position.x
	var posy = global_position.y
	global_position.x = lerp(posx, x, 0.2)
	global_position.y = lerp(posy, y, 0.2)