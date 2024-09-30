extends Node3D
@export var colliders = []
@export var walls = []
const DOOR_CONTROLLER = preload("res://scenes/parts/door_controller.tscn")
var block 
enum enumDirection {FORE,BACK,LEFT,RIGHT,UP,DOWN}
var direction = {
	Vector3(1,0,0):enumDirection.FORE,
	Vector3(-1,0,0):enumDirection.BACK,
	Vector3(0,0,-1):enumDirection.LEFT,
	Vector3(0,0,1):enumDirection.RIGHT,
	Vector3(0,1,0):enumDirection.UP,
	Vector3(0,-1,0):enumDirection.DOWN,
}
var wallInteractors = []
var wallVectors = {}
var neighbors = []
var doors = {}
var props = {} ## Node
var blockPos
# Called when the node enters the scene tree for the first time.
func _init():
	pass
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_passage_type_set():
	block = get_parent()
	block.parentShip.connect("block_added", Callable(self, "_on_block_added"))
	
func _on_block_added(placePos):
	blockPos = block.parentShip.blocks.find_key(block)
	if placePos != blockPos: return
	for child in get_parent().get_children():
		if child is MeshInstance3D:
			walls.append(child)
	for child in get_children():
		if child is Area3D:
			wallInteractors.append(child)
	for wall in wallInteractors:
		wallVectors[wall] = direction.keys()[wallInteractors.find(wall)]
	colliders = block.colliders
	block.rotation = Vector3(0,0,0)
	update_walls()

func update_walls(checkState:bool=false,selectedWall:Node=null,placeDoor=false,placeRotation=0):
	neighbors = block.parentShip.get_neighbors(blockPos, block.parentShip.passageDictionary)
	
	if selectedWall:
		var selectedWallDirection = wallVectors.get(selectedWall)
		
		var singleNeighbor = blockPos - selectedWallDirection
		
		if (singleNeighbor in neighbors) or placeDoor:
			var doorRef = toggle_wall(selectedWallDirection,checkState,placeDoor,placeRotation)
			if !block.parentShip.blocks.get(singleNeighbor): 
				return
			if singleNeighbor in neighbors:
				var neighborBlock = block.parentShip.blocks.get(singleNeighbor)
				var neighborPassage = neighborBlock.get_node("passage_controller")
				neighborPassage.toggle_wall(-selectedWallDirection,checkState,placeDoor,placeRotation,doorRef)
			return
		else:
			print("cannot replace exterior wall")
		return
		
		
	for neighborPos in neighbors:
		var blockRelative = blockPos - neighborPos
		if (blockRelative not in direction): return
		toggle_wall(blockRelative,checkState)

		if !block.parentShip.blocks.get(neighborPos): 
			return
		var neighborBlock = block.parentShip.blocks.get(neighborPos)
		var neighborPassage = neighborBlock.get_node("passage_controller")
		neighborPassage.toggle_wall(-blockRelative,checkState)

func toggle_wall(blockRelative,state:bool=false,placeDoor=false, placeRotation=PI/2, doorRef:Node=null):
	var checkDirection = direction[blockRelative]
	if placeDoor:
		var door
		if !state:
			colliders[checkDirection].disabled = !state
			walls[checkDirection].visible = state
			if doors.find_key(checkDirection): return
			if doorRef != null: 
				print("doorRef")
				doors[doorRef] = walls[checkDirection]
				return  
			door = DOOR_CONTROLLER.instantiate()
			add_child(door)
			doors[door] = checkDirection
			door.position = walls[checkDirection].position
			var temp = blockRelative.z
			
			door.basis =   walls[checkDirection].basis.rotated(blockRelative,placeRotation)
			uiLog.p2 = str(blockRelative * placeRotation)
			uiLog.p3 = str(door.rotation)
			return door
		else:
			var trash = doors.find_key(checkDirection)
			doors.erase(trash)
			colliders[checkDirection].disabled = !state
			walls[checkDirection].visible = state
			if !trash: return
			trash.remove()
	else:
		colliders[checkDirection].disabled = !state
		walls[checkDirection].visible = state

func _on_passage_on_remove() -> void:
	for door in doors:
		door.remove()
	update_walls(true)
