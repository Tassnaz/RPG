@icon("res://icon.svg")

extends Area2D

class_name Pickup_ItemClass

var item_ID: int
var item_name: String
var interacting: bool = false

@export var item_select = InventoryManager.item_type.test_item
@export var pickup_amount: int = 1

func _ready() -> void:
	var enum_names = InventoryManager.item_type.keys()
	item_name = enum_names[item_select].capitalize()
	
	item_ID = item_select
	
	body_entered.connect(player_entered)
	body_exited.connect(player_exited)
	
func _process(delta: float) -> void:
	if interacting and Input.is_action_just_pressed("Interact"):
		pickup()
		
func pickup():
	print ("Player picked up ", pickup_amount, " ", item_name)
	InventoryManager.add_item(item_ID, pickup_amount, item_name)
	queue_free()

func player_entered(body: Node2D):
	if body is Player:
		interacting = true
		
func player_exited(body: Node2D):
	if body is Player:
		interacting = false
		
