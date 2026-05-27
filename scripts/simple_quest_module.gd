extends Node2D

@export var NPC_node :NPCwithDialog
@export var quest_dialog_completed :Array[String]

func _ready() -> void:
	Global.quest_1_signal.connect(update_quest)
	
	if Global.simple_quest_tracker["Quest 1"] == true:
		NPC_node.dialog_size = quest_dialog_completed.size()-1
		NPC_node.dialog_array = quest_dialog_completed

func update_quest():
	NPC_node.dialog_size = quest_dialog_completed.size()-1
	NPC_node.dialog_array = quest_dialog_completed
	
	Global.simple_quest_tracker["Quest 1"] = true
