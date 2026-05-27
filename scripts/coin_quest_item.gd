extends Area2D

var interacting :bool = false

func _ready() -> void:
	if Global.simple_quest_tracker["Quest 1"] == true:
		queue_free()
		
		
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact") and interacting:
		Global.quest_1_signal.emit()
		queue_free()
		
		
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		interacting = true
		

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("players"):
		interacting = false
