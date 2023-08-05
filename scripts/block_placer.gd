extends RayCast3D
var rayCast = self
var selectedBlock 
@export var placeTarget:Node 
var placeNormal:Vector3
var placeReference:Vector3
var lastPlaceTarget
var lastPlaceNormal
@export var targetShip:Node
var lastTargetShip
var placeRotation = Quaternion()
var lastBlock

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_inputs()
	check_ray()

func get_inputs():
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
	if Input.is_action_just_pressed("left_click") && placeTarget != null:
		targetShip.addBlock(placeReference,placeRotation,selectedBlock)
	if Input.is_action_just_pressed("right_click") && targetShip is RigidBody3D:
		targetShip.remove_block(placeTarget)

func check_ray():	#placement raycast, calls target ship controller, will check what block is placed
	if selectedBlock == null: return
	if !rayCast.is_colliding():
		if lastTargetShip != null:
			lastTargetShip.preselect(null, Vector3.ZERO, placeRotation, "structure_block")
			placeTarget = null
			placeNormal = Vector3.ZERO
			lastTargetShip = null
		return 
	placeTarget = rayCast.get_collider()
	if placeTarget == null: return
	targetShip = placeTarget.get_parentship()
	if targetShip == null:
		return
	placeNormal = rayCast.get_collision_normal()
	if (placeTarget != lastPlaceTarget or placeNormal != lastPlaceNormal):
		if lastTargetShip != null && targetShip != lastTargetShip:
			lastTargetShip.preselect(null, Vector3.ZERO, placeRotation, selectedBlock)
			return
	lastPlaceTarget = placeTarget
	lastPlaceNormal = placeNormal
	lastTargetShip = targetShip
	placeReference = targetShip.preselect(placeTarget,placeNormal,placeRotation,selectedBlock)

func _on_player_ui_block_selection(block_name):
	selectedBlock = block_name
