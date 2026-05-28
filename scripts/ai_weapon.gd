extends Area2D

var Type: String = "weapon"

@export var damage: int = 10

func _on_cooldown_timeout() -> void:
	
