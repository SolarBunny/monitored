extends Camera2D

func _process(delta):
	var player_pos = get_node("../Player").global_position
	var x = floor(player_pos.x / 480) * 480
	var y = floor(player_pos.y / 270) * 270
	global_position = Vector2(x, y)