extends Area2D

@export var damage: int = 10
@export var attack_duration: float = 0.3
@export var attack_delay: float = 1.0

@onready var enemy: CharacterBody2D = get_parent()
@onready var enemy_animated_sprite: AnimatedSprite2D = enemy.get_node("AnimatedSprite2D")
@onready var player: CharacterBody2D = get_parent().get_parent().get_parent().get_node("Player")

@onready var attack_delay_timer: Timer = $AttackDelay
@onready var attack_duration_timer: Timer = $AttackDuration
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var attack_sensor: Area2D = $AttackSensor
@onready var hit_sound: AudioStreamPlayer2D = $HitSound

func _ready() -> void:
	self.visible = false
	collision_shape.disabled = true
	
	attack_delay_timer.wait_time = attack_delay
	attack_duration_timer.wait_time = attack_duration
	
	attack_delay_timer.connect("timeout", attack)
	attack_duration_timer.connect("timeout", attack_done)
	
	attack_sensor.connect("body_entered", player_entered_attack_sensor)
	attack_sensor.connect("body_exited", player_exited_attack_sensor)

func attack():
	self.visible = true
	attack_duration_timer.start()
	hit_sound.play()
	
	# Runs the corresponding attack animation based on player position.
	var direction = enemy.global_position.direction_to(player.global_position)
	
	enemy_animated_sprite.flip_h = direction.x < 0
	
	var abs_x = abs(direction.x)
	var abs_y = abs(direction.y)
	
	if abs_y < 0.4:
		enemy_animated_sprite.play("attacking_right")
	elif abs_x <0.4:
		if direction.y > 0:
			enemy_animated_sprite.play("attacking_down")
		else:
			enemy_animated_sprite.play("attacking_up")
	else:
		if direction.y > 0:
			enemy_animated_sprite.play("attacking_down_right")
		else:
			enemy_animated_sprite.play("attacking_up_right")
			
	collision_shape.disabled = false
	await enemy_animated_sprite.animation_finished
	collision_shape.disabled = false
	
	
	
func attack_done():
	self.visible = false
	collision_shape.disabled = true
	attack_delay_timer.start()
	
	
func player_entered_attack_sensor(body: Node2D):
	if body.is_in_group("players"):
		attack_delay_timer.start()
		
		print("Enemy attacking")

func player_exited_attack_sensor(body: Node2D):
	if body.is_in_group("players"):
		attack_delay_timer.stop()
