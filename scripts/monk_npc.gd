extends CharacterBody2D
class_name NPCwithDialog

var interacting :bool = false
var dialog_counter :int = 0
var dialog_size :int

@export var npc_name :String
@export var dialog_array :Array[String]

@onready var dialog_box :Control = $DialogBox
@onready var dialog_label : Label = $DialogBox/Dialog
@onready var name_label : Label = $DialogBox/Name

func _ready() -> void:
	dialog_size = dialog_array.size() -1
	
	dialog_box.visible = false
	
	name_label.text = npc_name
	dialog_label.text = ""
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact") and interacting:
		talked_to()

func talked_to():
	dialog_box.visible = true
	
	if dialog_counter <= dialog_size:
		dialog_label.text = dialog_array[dialog_counter]
		dialog_counter += 1
		
	else:
		dialog_counter = 0
		dialog_box.visible = false

func _on_interact_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		interacting = true

func _on_interact_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("players"):
		interacting = false
		dialog_counter = 0
		dialog_box.visible = false
		
