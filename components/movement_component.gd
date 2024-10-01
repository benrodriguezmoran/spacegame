extends Node
@export var current_state:Node
@onready var playerBody = $".."
@onready var jetpackState = $jetpackState
@onready var walkState = $walkState
signal transitioned_state(state)
var inputForce = Vector3()
var mouseInput = Vector2()
var mouse_delta = Vector2()
var mouse_x_sensitivity = 10
var mouse_y_sensitivity = 20
# Called when the node enters the scene tree for the first time.
func _ready():
	current_state = jetpackState
	
func _input(event):
	if event is InputEventMouseMotion && Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED: #MOUSE_INPUT
		mouse_delta = event.relative
		



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	inputForce.z = Input.get_axis("fore","aft")
	inputForce.x = Input.get_axis("left","right")
	inputForce.y = Input.get_axis("down","up")
	mouseInput = Vector2(mouse_delta.y*-mouse_y_sensitivity,mouse_delta.x*-mouse_x_sensitivity)
	inputForce = playerBody.basis * inputForce.normalized()
	current_state.movement_process(inputForce,mouseInput)
	if Input.is_action_just_released("jetpack"):
		if current_state == jetpackState:
			emit_signal("transitioned_state", walkState)
			current_state = walkState
		else:
			current_state = jetpackState
			emit_signal("transitioned_state", jetpackState)
	mouse_delta = Vector2.ZERO


	
