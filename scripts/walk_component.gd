extends Node

@onready var walk_raycast = $"../../walk_raycast"
@onready var player:RigidBody3D = $"../.."
var floor:Node3D
var maxSpeed = 5
var walkForce = 300
var vecMaxSpeed = Vector2(maxSpeed,maxSpeed)
var magForce = 500
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func movement_process(inputVector):
	if !walk_raycast.is_colliding(): return
	floor = walk_raycast.get_collider()
	var floorNormal = walk_raycast.get_collision_normal()
	var floorPoint = walk_raycast.get_collision_point()
	var walkInput = Vector3(0.0,-magForce, 0.0)
	var relativeVelocity = (player.linear_velocity - floor.linear_velocity)
	player.apply_central_force((inputVector * walkForce)+walkInput)
	#player.apply_force(Vector3(0.0,-magForce,0.0)*floorNormal,walk_raycast.position * player.basis)
	#player.rotation = floorNormal
	floor.apply_force(floorNormal*-magForce,floorPoint)
#	var walkForce = clamp(relativeVelocity,-vecMaxSpeed,vecMaxSpeed)
	print(floorPoint)
#	player.apply_central_force(walkInput*5 - Vector3(walkForce.x,0,walkForce.y))
	

func _on_movement_component_transitioned_state(state):
	pass # Replace with function body.
