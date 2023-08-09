extends Node
var mouse_x_sensitivity = 10
var mouse_y_sensitivity = 20
var roll_sensitivity = 300
var thrust_multiplier = 1500
var jetpack:bool = true
var mouse_delta: Vector2
@onready var playerBody = $"../.."
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(_delta):
	#input
	if Input.is_action_just_released("jetpack"):
		jetpack = !jetpack
	var inputForce = Vector3()
	inputForce.z = Input.get_axis("fore","aft")
	inputForce.x = Input.get_axis("left","right")
	inputForce.y = Input.get_axis("down","up")
	inputForce = playerBody.transform.basis * inputForce.normalized()
	var roll = -Input.get_axis("roll_left","roll_right")*roll_sensitivity
	if jetpack:
		playerBody.apply_central_force(inputForce * thrust_multiplier)
		playerBody.apply_torque(playerBody.transform.basis * Vector3(mouse_delta.y*-mouse_y_sensitivity,mouse_delta.x*-mouse_x_sensitivity,roll))
		playerBody.set_angular_damp(5)
	else:
		playerBody.set_linear_damp(0)
		playerBody.set_angular_damp(0.1)
			
	#Braking Force
	if inputForce == Vector3.ZERO && playerBody.linear_velocity.length()>1 && jetpack:
		playerBody.apply_central_force(-playerBody.linear_velocity.normalized()*thrust_multiplier)
	if inputForce == Vector3.ZERO && playerBody.linear_velocity.length()<1 && jetpack:
		playerBody.set_linear_damp(2)
	else:
		playerBody.set_linear_damp(0)
	mouse_delta = Vector2.ZERO
	
	
func _input(event):
	if event is InputEventMouseMotion && Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED: #MOUSE_INPUT
		mouse_delta = event.relative
