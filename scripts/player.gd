extends RigidBody3D
@onready var light_3d: SpotLight3D = $SpotLight3D
@onready var light_3d_2: SpotLight3D = $SpotLight3D2
var state = true
var energy:float = 4.0
var max_energy = 4
signal ui_velocity
func _ready():
	set_contact_monitor(true)

func _process(_delta):
	if Input.is_action_just_pressed("light"):
		if state == false:
			energy = max_energy
			state = true
		elif state == true:
			energy = 0
			state = false
	light_3d.light_energy = lerp(light_3d.light_energy, energy, .1)
	light_3d_2.light_energy = lerp(light_3d_2.light_energy, energy, .1)
