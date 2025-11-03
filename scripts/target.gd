extends CharacterBody2D


# Värden
@export var max_speed = 400
@export var acceleration = 1000
@export var friction = 1500

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
		$AnimationPlayer.play("Left")
	
	elif Input.is_action_pressed("Right") && !Input.is_action_pressed("Left"):
		$AnimationPlayer.play("Right")
	
	elif Input.is_action_pressed("Up"):
		$AnimationPlayer.play("Up")
	
	elif Input.is_action_pressed("Down"):
		$AnimationPlayer.play("Down")
	
	else: 
		$AnimationPlayer.stop()


func _on_switch_target_hitbox_body_entered(body):
	if body.name == "Enemy":
		Global.CurrentTarget = 2
