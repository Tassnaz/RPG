extends CharacterBody2D


# Variables
var is_attacking: bool = false
var invincible: bool = false

@export var HP: int = 100
@export var max_speed: float = 350.0
@export var acceleration: float = 1500.0
@export var friction: float = 3000.0

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var sword: Area2D = $Sword
@onready var invincible_timer: Timer = $InvincibleTimer

func _ready():
	# Connect signal
	sword.attack_triggered.connect(_on_sword_attack_triggered)

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
	if is_attacking == false:
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

func attacked(damage):
	HP -= damage
	print ("Player HP is ", HP)
	
	invincible = true
	anim_player.play("invincible_flash")
	invincible_timer.start()
	
	if HP <= 0:
		get_tree().reload_current_scene()

func _on_sword_attack_triggered():
	is_attacking = true
	anim_sprite.play("Attack 1")
	await anim_sprite.animation_finished
	is_attacking = false
	
func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy_weapons") and not invincible:
		attacked(area.damage)

func _on_invincible_timer_timeout() -> void:
	anim_player.stop()
	invincible = false
