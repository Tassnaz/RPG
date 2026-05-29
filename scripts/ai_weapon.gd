extends Area2D

@export var damage: int = 10
@export var attack_duration: float = 0.3
@export var attack_delay: float = 1.0

@onready var attack_delay_timer: Timer = $AttackDelay
@onready var attack_duration_timer: Timer = $AttackDuration
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var attack_sensor: Area2D = $AttackSensor

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
	collision_shape.disabled = false
	attack_duration_timer.start()

func attack_done():
	self.visible = false
	collision_shape.disabled = true
	attack_delay_timer.start()
	
func player_entered_attack_sensor(body: Node2D):
	if body.is_in_group("players"):
		attack_delay_timer.start()

func player_exited_attack_sensor(body: Node2D):
	if body.is_in_group("players"):
		attack_delay_timer.stop()
