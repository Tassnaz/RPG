extends CharacterBody2D

@export var HP = 100
var can_move = true

# Define targets
@export var PathToTarget: NodePath
@export var PathToTarget2: NodePath

# Movement values
@export var MaxSpeed = 150
var Acceleration = 8.0

# Node References
# Vi sparar referenser till båda målen här för att spara prestanda
@onready var TargetNode1 = get_node_or_null(PathToTarget)
@onready var TargetNode2 = get_node_or_null(PathToTarget2)
@onready var CurrentTargetNode = TargetNode1 # Startar med Target 1

@onready var NavAgent = $NavigationAgent2D
@onready var UpdatePathTimer = $UpdateTimer

func _ready():
	# Sätter första pathfinding-punkten direkt
	updatePath()
	
	# Kopplar timern. Om timern i editorn är satt till "One Shot: false", 
	# behöver du inte starta den manuellt inuti funktionen.
	UpdatePathTimer.timeout.connect(updatePath)
	UpdatePathTimer.start()

func updatePath():
	if CurrentTargetNode != null:
		NavAgent.target_position = CurrentTargetNode.global_position

func _physics_process(delta):
	
	$HealthBar.value = HP
	
	# Ändrar vilket target vi följer baserat på global variabel
	if Global.CurrentTarget == 2:
		CurrentTargetNode = TargetNode2
	else:
		CurrentTargetNode = TargetNode1
	
	# Om Navigationen är klar eller vi inte får röra oss, stanna.
	if NavAgent.is_navigation_finished() or can_move == false:
		# Saktar ner mjukt till 0
		velocity = velocity.lerp(Vector2.ZERO, Acceleration * delta)
		move_and_slide()
		return

	# Hämta nästa position från NavigationAgent
	var CurrentAgentPosition = global_position
	var NextPathPosition = NavAgent.get_next_path_position()
	
	# Räkna ut riktning och steering
	var Direction = CurrentAgentPosition.direction_to(NextPathPosition)
	var TargetVelocity = Direction * MaxSpeed
	
	# "Steering behavior" - mjuk sväng
	var Steering = (TargetVelocity - velocity) * delta * Acceleration
	velocity += Steering
	
	# Godot 4 hanterar rörelse automatiskt med den inbyggda 'velocity'-variabeln
	move_and_slide()


func _on_hit_box_area_entered(area):
	
	if area.get("Type") == "weapon":
		print ("Enemy has been attacked")
		
		HP = HP - area.get("Damage")
		print ("Enemy HP is ", HP)
		
		if HP <= 0:
			queue_free()
			
		$HitCoolDown.start()
		can_move = false


func _on_hit_cool_down_timeout():
	can_move = true
