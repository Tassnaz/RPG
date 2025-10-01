extends CharacterBody2D


var CanGrab = false

var Offset = Vector2()

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		CanGrab = event.pressed
		
		Offset = position - get_global_mouse_position()

func _process(_delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && CanGrab:
		position = get_global_mouse_position() + Offset
