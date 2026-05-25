extends CharacterBody2D

var HP: int = 100
var knockback_velocity: Vector2 = Vector2.ZERO

@export var knockback_friction: float = 10.0


func _ready():
	pass

func _physics_process(delta):
	
	$HealthBar.value = HP
	
	if HP <= 0:
		queue_free()
	
	knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, knockback_friction * delta * 100)
	
	velocity = knockback_velocity
	
	move_and_slide()
	

func apply_knockback(force: Vector2):
	knockback_velocity = force


func _on_hit_box_area_entered(area):
	# Det som händer när man slår fienden
	if area.get("Type") == "weapon":
		print ("Enemy has been atacked")
		$HurtFlash.play("HurtFlash")
		
		HP = HP - area.get("Damage")
		print ("Enemy hp is ", HP)
		
		
