extends Node

@export var amount_to_heal: int = 10


func _on_use_meat_use_item() -> void:
	BuffManager.player_heal.emit(amount_to_heal)
