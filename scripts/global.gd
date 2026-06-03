extends Node

signal quest_1_signal

var player_maxHP: int
var player_currentHP: int

signal update_playerHP(player_maxHP, player_currentHP)


var simple_quest_tracker :Dictionary = {
	"Quest 1": false
}
