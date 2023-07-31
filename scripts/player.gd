extends RigidBody3D
class_name player_class
var mouse_x_sensitivity = 10
var mouse_y_sensitivity = 20
var roll_sensitivity = 300
var thrust_multiplier = 1500
var jetpack:bool = true

@onready var rayCast = $block_placer
var mouse_delta: Vector2
var zoom

func _ready():
	pass

func _process(_delta):
	pass
	
func _physics_process(_delta):
	#input
	if Input.is_action_just_released("jetpack"):
		jetpack = !jetpack
	var inputForce = Vector3()
	inputForce.z = Input.get_axis("fore","aft")
	inputForce.x = Input.get_axis("left","right")
	inputForce.y = Input.get_axis("down","up")
	inputForce = transform.basis * inputForce.normalized()
	var roll = -Input.get_axis("roll_left","roll_right")*roll_sensitivity
	if jetpack:
		apply_central_force(inputForce * thrust_multiplier)
		apply_torque(transform.basis * Vector3(mouse_delta.y*-mouse_y_sensitivity,mouse_delta.x*-mouse_x_sensitivity,roll))
		set_angular_damp(5)
	else:
		set_linear_damp(0)
		set_angular_damp(0.1)
			
	#Braking Force
	if inputForce == Vector3.ZERO && linear_velocity.length()>1 && jetpack:
		apply_central_force(-linear_velocity.normalized()*thrust_multiplier)
	if inputForce == Vector3.ZERO && linear_velocity.length()<1 && jetpack:
		set_linear_damp(2)
	else:
		set_linear_damp(0)
	mouse_delta = Vector2.ZERO
	
	
func _input(event):
	if event is InputEventMouseMotion && Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED: #MOUSE_INPUT
		mouse_delta = event.relative
	

		

