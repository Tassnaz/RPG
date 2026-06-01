extends CharacterBody2D

var HP: int = 100
var knockback_velocity: Vector2 = Vector2.ZERO
var player: Node2D
var player_detected: bool = false
var distance_to_player: float


@export var knockback_friction: float = 10.0
@export var speed: float = 100.0
@export var attack_range: float = 50.0

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	player = get_tree().get_first_node_in_group("players")

func _physics_process(delta):
	# Uppdates health bar
	$HealthBar.value = HP
	
	# Calculates distance between enemy and player.
	distance_to_player = global_position.distance_to(player.global_position)
	
	if player == null:
		return
		
	# If player is detected and distance between is greater than the attack range navigate towards player.
	if player_detected and distance_to_player >= attack_range:
		
		animated_sprite.play("running")
		
		# Tells the NavAgent where to go
		nav_agent.target_position = player.global_position
		
		# Gets the next point along the path
		var next_point = nav_agent.get_next_path_position()
		var direction = global_position.direction_to(next_point)
	
		velocity = (direction * speed) + knockback_velocity
	
	# If the enemy is within attack range, stop and only apply knockback to velocity.
	else:
		velocity = knockback_velocity
	
	# Handles death
	if HP <= 0:
		queue_free()
		return
		
	
	knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, knockback_friction * delta * 100)
	
	move_and_slide()


func apply_knockback(force: Vector2):
	knockback_velocity = force


func _on_hit_box_area_entered(area):
	# Det som händer när man slår fienden
	if area.is_in_group("weapons"):
		print ("Enemy has been atacked")
		$HurtFlash.play("HurtFlash")
		
		HP = HP - area.get("Damage")
		print ("Enemy hp is ", HP)


func _on_player_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		player_detected = true
