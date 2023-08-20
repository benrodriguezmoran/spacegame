extends Node
@export var current_state:Node
@onready var jetpackState = $jetpackState
@onready var walkState = $walkState
# Called when the node enters the scene tree for the first time.
func _ready():
	current_state = jetpackState

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	current_state.movement_process()
	if Input.is_action_just_released("jetpack"):
		if current_state == jetpackState:
			current_state = walkState
		else:
			current_state = jetpackState
	

	
