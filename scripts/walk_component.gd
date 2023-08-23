extends Node

@onready var walk_raycast = $"../../walk_raycast"
@onready var player:RigidBody3D = $"../.."
var floor:Node
var maxSpeed = 5
var vecMaxSpeed = Vector2(maxSpeed,maxSpeed)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func movement_process(inputForce):
	if !walk_raycast.is_colliding(): return
	floor = walk_raycast.get_collider()
	var floorNormal = walk_raycast.get_collision_normal()
	var walkInput = Vector3(inputForce.x, 0 ,inputForce.z)
	var relativeVelocity = player.linear_velocity - floor.linear_velocity
#	var walkForce = clamp(relativeVelocity,-vecMaxSpeed,vecMaxSpeed)
	print(relativeVelocity)
#	player.apply_central_force(walkInput*5 - Vector3(walkForce.x,0,walkForce.y))
	

func _on_movement_component_transitioned_state(state):
	pass # Replace with function body.



