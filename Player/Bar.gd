extends TextureProgress

onready var player_health = get_parent().get_parent().get_parent().get("health")

func _ready():
	value = player_health

func _on_Player_damaged(new_health):
	value = new_health
