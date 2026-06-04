extends Node

signal add_item_to_UI(ID: int)

enum item_type {
	test_item,
	meat,
	speed_potion,
	quest_key_1,
}

enum item {AMOUNT, NAME}

var use_item_load: Dictionary [int, PackedScene] = {
	item_type.meat: preload("res://Scenes/use_Meat.tscn")
}

var inventory :Dictionary = {
	item_type.test_item: [0, "test item"],
	
}

func add_item(ID: int, amount: int, item_name: String):
	if not ID in item_type.values():
		push_error("No item ID found, it is wrong or does not exist. ID: " +str(ID))
		return
		
	if amount <1:
		push_error("Amount was: " + str(amount) + "Cannot add negative or 0 amount to item.")
		assert(false, "Incorrect amount in add item function")
		return
		
	if not inventory.has(ID):
		inventory[ID] = [amount,item_name]
		print ("Added ", inventory[ID][item.AMOUNT], " ",inventory[ID][item.NAME], " to inventory")
		
	else:
		inventory[ID][item.AMOUNT] += amount
		print ("Added ", amount," ",inventory[ID][item.NAME], " to inventory")
	print (inventory)
	
	add_item_to_UI.emit(ID)
	
func remove_item(ID: int, amount: int):
	if not inventory.has(ID):
		push_warning("Error - item not found. ID: " + str(ID) + "Could not remove item")
		return
		
	if not amount > inventory[ID][item.AMOUNT]:
		inventory[ID][item.AMOUNT] -= amount
		print ("Removed ", amount, " from ", inventory[ID][item.NAME], "from inventory")
	else:
		inventory[ID][item.AMOUNT] = 0
		push_error("Item amount should not be negative in" + inventory[ID][item.NAME] + ".")
		return
	
	if inventory[ID][item.AMOUNT] == 0:
		print ("Removed", inventory[ID][item.NAME], " from inventory")
		inventory.erase(ID)
