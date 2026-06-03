class_name Use_ItemClass
extends Panel

signal use_item()

var item_ID: int
var interacting: bool = false

@export var item_select = InventoryManager.item_type.test_item
@export var amount: int = 1

@onready var focus_window: Panel = $Panel

func _ready() -> void:
	
	item_ID = item_select
	
	focus_window.visible = false
	
	mouse_entered.connect(mouse_over)
	mouse_exited.connect(mouse_exit)
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("inventory_use") and interacting:
		use_item_action()
	
func use_item_action() -> void:
	use_item.emit()
	InventoryManager.remove_item(item_ID,amount)
	queue_free()

func mouse_over() -> void:
	focus_window.visible = true
	interacting = true
	
func mouse_exit() -> void:
	focus_window.visible = false
	interacting = false
