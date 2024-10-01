extends Node

var roll_sensitivity = 300
var thrust_multiplier = 1500

@onready var playerBody = $"../.."
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func movement_process(inputForce:Vector3,mouseInput:Vector2):
	#input
	var roll = -Input.get_axis("roll_left","roll_right")*roll_sensitivity
	var rotationInputs = Vector3(mouseInput.x,mouseInput.y,roll)
	playerBody.apply_central_force(inputForce * thrust_multiplier)
	playerBody.apply_torque(playerBody.basis * rotationInputs)
	playerBody.set_angular_damp(5)
	#Braking Force
	if inputForce == Vector3.ZERO && playerBody.linear_velocity.length()>1:
		playerBody.apply_central_force(-playerBody.linear_velocity.normalized()*thrust_multiplier)
	if inputForce == Vector3.ZERO && playerBody.linear_velocity.length()<1:
		playerBody.set_linear_damp(2)
	else:
		playerBody.set_linear_damp(0)
	

func _on_movement_component_transitioned_state(state):
	if state == self:
		pass
	else:
		playerBody.set_linear_damp(0)
		playerBody.set_angular_damp(0)
