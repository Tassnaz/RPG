extends Area2D

var is_interacting_with: bool = false
var dialog_counter: int = 1
var max_dialog: int = 0


@export var dialog: Dictionary = {
	
	1: "Hej",
	
	2: "Jag är en trolkarl",
}

func _ready():
	$DialogBox.visible = false
	max_dialog = dialog.size()



func _on_body_entered(body):
	if body.name == "Player":
		is_interacting_with = true
	

func _on_body_exited(body):
	if body.name == "Player":
		Global.current_dialog = ""
		is_interacting_with = false
		$DialogBox.visible = false
