extends Area2D

signal attack_triggered

var is_attacking = false
var Type = "weapon"

@export var Damage: int = 20
@export var knockback_force: float = 300.0


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
	if body.is_in_group("enemies"):
		var knockback_dir = (body.global_position - global_position).normalized()
		body.apply_knockback(knockback_dir * knockback_force)
