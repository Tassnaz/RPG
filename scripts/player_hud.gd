extends Control

@onready var player_health_bar: TextureProgressBar = $PlayerHealthBar/Frame/Fill

func _ready() -> void:
	player_health_bar.max_value = Global.player_maxHP
	player_health_bar.value = Global.player_currentHP
	
	Global.update_playerHP.connect(update)
	
func update(player_maxHP, player_currentHP):
	player_health_bar.max_value = player_maxHP
	player_health_bar.value = player_currentHP
