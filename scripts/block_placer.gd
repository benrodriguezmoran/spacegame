extends Node
@onready var rayCast = $".."

@export var placeTarget:Node 
@export var placeNormal:Vector3
var placeReference:Vector3
var lastPlaceTarget
var lastPlaceNormal
@export var targetShip:Node
var lastTargetShip
var placeRotation:Quaternion = Quaternion()
var lastBlock

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func check_ray(selectedBlock:String):	#placement raycast, calls target ship controller, will check what block is placed
	if Input.is_action_just_pressed("flipX"):
		placeRotation *= Quaternion(Vector3(1,0,0), -PI/2)
	if Input.is_action_just_pressed("flipX-"):
		placeRotation *= Quaternion(Vector3(1,0,0), PI/2)
	if Input.is_action_just_pressed("flipY"):
		placeRotation *= Quaternion(Vector3(0,0,1), -PI/2)
	if Input.is_action_just_pressed("flipY-"):
		placeRotation *= Quaternion(Vector3(0,0,1), PI/2)
	if Input.is_action_just_pressed("flipZ"):
		placeRotation *= Quaternion(Vector3(0,1,0), PI/2)
	if Input.is_action_just_pressed("flipZ-"):
		placeRotation *= Quaternion(Vector3(0,1,0), -PI/2)
	if selectedBlock == null: return
	if !rayCast.is_colliding():
		if lastTargetShip != null:
			lastTargetShip.preselect(null, Vector3.ZERO, placeRotation)
			placeTarget = null
			placeNormal = Vector3.ZERO
			lastTargetShip = null
		return 
	placeTarget = rayCast.get_collider()
	if placeTarget == null or !placeTarget.has_meta("block"): return
	targetShip = placeTarget.get_parentship()
	if targetShip == null:
		return
	placeNormal = rayCast.get_collision_normal()
	if lastTargetShip != null and targetShip != lastTargetShip:
		lastTargetShip.preselect(null, Vector3.ZERO, placeRotation, selectedBlock)
		lastTargetShip = null
	lastPlaceTarget = placeTarget
	lastPlaceNormal = placeNormal
	lastTargetShip = targetShip
	placeReference = targetShip.preselect(placeTarget,placeNormal,placeRotation,selectedBlock)
	if Input.is_action_just_pressed("left_click") && placeTarget != null:
		targetShip.addBlock(placeReference,placeRotation,selectedBlock)
	if Input.is_action_just_pressed("right_click") && placeTarget != null && targetShip is RigidBody3D:
		targetShip.remove_block(placeTarget)

func _on_interaction_raycast_transitioned_state(state:Node):
	if state == self:
		rayCast.set_collision_mask_value(1, true)
	else:
		rayCast.set_collision_mask_value(1, false)
	if lastTargetShip != null:
		lastTargetShip.preselect(null, Vector3.ZERO, placeRotation, "structure_block")
		lastTargetShip = null
		
