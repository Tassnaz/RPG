extends Node2D

func _process(delta):
	$Control/Text.text = Global.current_dialog
