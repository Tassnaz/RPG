extends CharacterBody2D

var HP: int = 100

func _ready():
	pass

func _physics_process(delta):
	
	$HealthBar.value = HP
	
	if HP <= 0:
		queue_free()

func _on_hit_box_area_entered(area):
	# Det som händer när man slår fienden
	if area.get("Type") == "weapon":
		print ("Enemy has been atacked")
		$HurtFlash.play("HurtFlash")
		
		HP = HP - area.get("Damage")
		print ("Enemy hp is ", HP)
		
