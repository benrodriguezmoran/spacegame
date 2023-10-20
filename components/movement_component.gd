extends Node
@export var current_state:Node
@onready var playerBody = $".."
@onready var jetpackState = $jetpackState
@onready var walkState = $walkState
signal transitioned_state(state)
# Called when the node enters the scene tree for the first time.
func _ready():
	current_state = jetpackState
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	var inputForce = Vector3()
	inputForce.z = Input.get_axis("fore","aft")
	inputForce.x = Input.get_axis("left","right")
	inputForce.y = Input.get_axis("down","up")
	inputForce = playerBody.basis * inputForce.normalized()
	current_state.movement_process(inputForce)
	if Input.is_action_just_released("jetpack"):
		if current_state == jetpackState:
			emit_signal("transitioned_staate", walkState)
			current_state = walkState
		else:
			current_state = jetpackState
			emit_signal("transitioned_state", jetpackState)
	

	
