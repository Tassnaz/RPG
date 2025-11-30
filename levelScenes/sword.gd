extends Area2D

var is_attacking = false
@export var Damage = 10
var Type = "weapon"


func _ready():
	self.visible = false
	$CollisionPolygon2D.disabled = true
	
func _physics_process(delta):
	
	if Input.is_action_just_pressed("Attack") && is_attacking == false:
		self.visible = true
		$CollisionPolygon2D.disabled = false
		
		is_attacking = true
		$CoolDown.start()


func _on_cool_down_timeout():
	self.visible = false
	$CollisionPolygon2D.disabled = true
	is_attacking = false
	$CoolDown.stop()
	print("Attack!")
