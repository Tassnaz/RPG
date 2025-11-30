extends CharacterBody2D


var HP = 40
var can_move = true

# Variabel för att definera "Target"
@export var PathToTarget = NodePath()
@export var PathToTarget2 = NodePath()

# Variabler för hastighet och rörelse
var Velocity = Vector2.ZERO
@export var MaxSpeed = 280
var Acceleration = 8.0

# Kopplingar till olika noder
@onready var Target = get_node(PathToTarget)
@onready var NavAgent = $NavigationAgent2D
@onready var UpdatePathTimer = get_node("UpdateTimer")

func _ready():
	
	# Talar om vart "Target" är
	NavAgent.set_target_position(Target.global_position)
	
	# Kopplar timern med kod samt sätter igång den
	UpdatePathTimer.timeout.connect(updatePath)
	UpdatePathTimer.start()

func updatePath():
	
	NavAgent.set_target_position(Target.global_position)
	UpdatePathTimer.start()
	
func _physics_process(delta):
	# Ändrar target
	if Global.CurrentTarget == 2:
		Target = get_node(PathToTarget2)
	
	# Fixar så att enemy inte "gungar" när den är framme
	if NavAgent.is_navigation_finished():
		return
		
	var Direction = global_position.direction_to(NavAgent.get_next_path_position())
	var TargetVelocity = Direction * MaxSpeed
	var Steering = (TargetVelocity - velocity) * delta * Acceleration
	
	# Ökar velocity baserat på ekvationen ovan
	velocity += Steering
	
	# Rör Enemy
	Velocity = move_and_slide()
	
	if can_move == true:
		Velocity = move_and_slide(Velocity)
