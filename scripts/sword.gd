extends Area2D

signal attack_triggered

var is_attacking = false
var Type = "weapon"

@export var Damage = 20

@onready var spear_enemy_node: CharacterBody2D = get_parent().get_parent().get_node("spear_enemy")


func _ready():
	$CollisionPolygon2D.disabled = true
	
func _physics_process(delta):
	
	if Input.is_action_just_pressed("Attack") && is_attacking == false:
		$CollisionPolygon2D.disabled = false
		attack_triggered.emit()
		
		
		is_attacking = true
		$CoolDown.start()


func _on_cool_down_timeout():
	$CollisionPolygon2D.disabled = true
	is_attacking = false
	$CoolDown.stop()
	print("Attack!")
	
	
func _on_body_entered(body: Node2D) -> void:
	if body == spear_enemy_node:
		var knockback_direction = (body.global_position - global_position).normalized()
		body.apply_knockback(knockback_direction, 150.0, 0.12)
