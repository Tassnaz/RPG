extends CharacterBody2D


# Värden
@export var max_speed = 350
@export var acceleration = 1500
@export var friction = 3000

func _physics_process(delta):
	# Movement
	
	# Hämta Input
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	
	# OM man går i en riktning accelerera tills man når max_speed
	if direction != Vector2.ZERO:
		var target_velocity = direction * max_speed
		velocity = velocity.move_toward(target_velocity, acceleration * delta)
		
	# Sakta ner om man inte ger någon input
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	move_and_slide()
	
	
	# Animationer
	if Input.is_action_pressed("Left") && !Input.is_action_pressed("Right"):
		$AnimatedSprite2D.scale.x = -1
		$AnimatedSprite2D.play("Run")
		$Sword.rotation_degrees = -90
	
	elif Input.is_action_pressed("Right") && !Input.is_action_pressed("Left"):
		$AnimatedSprite2D.scale.x = 1
		$AnimatedSprite2D.play("Run")
		$Sword.rotation_degrees = 90
	
	elif Input.is_action_pressed("Up"):
		$AnimatedSprite2D.play("Run")
		$Sword.rotation_degrees = 0

	elif Input.is_action_pressed("Down"):
		$AnimatedSprite2D.play("Run")
		$Sword.rotation_degrees = 180
	
	else: 
		$AnimatedSprite2D.play("default")


func _on_switch_target_hitbox_body_entered(body):
	if body.name == "Enemy":
		Global.CurrentTarget = 2
