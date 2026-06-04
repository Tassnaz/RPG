extends Control

@onready var item_container: HBoxContainer = $PanelContainer/HBoxContainer


func _ready() -> void:
	
	visible = false
	
	InventoryManager.add_item_to_UI.connect(add_item_to_UI)

func _unhandled_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("Inventory"):
		if visible:
			visible = false
		else:
			visible = true

func add_item_to_UI(ID, amount) -> void:
	
	for item in amount:
		var item_to_add = InventoryManager.use_item_load[ID].instantiate()
		item_container.add_child(item_to_add)
