extends CharacterBody2D

var HP: int = 100
var knockback: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0

func _ready():
	pass

func _physics_process(delta):
	
	if knockback_timer > 0.0:
		velocity = knockback
		knockback -= delta
		if knockback_timer <= 0.0:
			knockback = Vector2.ZERO
	
	$HealthBar.value = HP
	
	if HP <= 0:
		queue_free()
	
	move_and_slide()

func apply_knockback(direction: Vector2, force: float, knockback_duration: float):
	knockback = direction * force
	knockback_timer = knockback_duration
	
	
func _on_hit_box_area_entered(area):
	# Det som händer när man slår fienden
	if area.get("Type") == "weapon":
		print ("Enemy has been atacked")
		$HurtFlash.play("HurtFlash")
		
		HP = HP - area.get("Damage")
		print ("Enemy hp is ", HP)
		
		
