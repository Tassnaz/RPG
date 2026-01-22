extends Area2D

var is_interacting_with: bool = false
var dialog_counter: int = 1
var max_dialog: int = 0


@export var dialog: Dictionary = {
	
	1: "Hello",
	
	2: "I am a wizzard",
}


func _ready():
	$DialogBox.visible = false
	max_dialog = dialog.size()
	
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact") && is_interacting_with == true:
		talked_to()


func talked_to():
	if dialog_counter <= max_dialog:
		Global.current_dialog = dialog.get(dialog_counter)
		
		dialog_counter += 1
		$DialogBox.visible = true
		
	elif dialog_counter > max_dialog:
		$DialogBox.visible = false
		dialog_counter = 1
	
	
func _on_body_entered(body):
	if body.name == "Player":
		is_interacting_with = true
	
	
func _on_body_exited(body):
	if body.name == "Player":
		Global.current_dialog = ""
		is_interacting_with = false
		$DialogBox.visible = false
