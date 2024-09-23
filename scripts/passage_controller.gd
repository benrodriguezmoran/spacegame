extends Node3D
@export var colliders = []
@export var walls = []
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

func update_walls(checkState:bool=false,selectedWall:Node=null,placeDoor=false):
	neighbors = block.parentShip.get_neighbors(blockPos, block.parentShip.passageDictionary)
	if selectedWall:
		var selectedWallDirection = wallVectors.get(selectedWall)
		
		var singleNeighbor = blockPos - selectedWallDirection
		
		if (singleNeighbor) in neighbors or placeDoor:
			toggle_wall(selectedWallDirection,checkState)
			if !block.parentShip.blocks.get(singleNeighbor): 
				return
			if (singleNeighbor) in neighbors:
				var neighborBlock = block.parentShip.blocks.get(singleNeighbor)
				var neighborPassage = neighborBlock.get_node("passage_controller")
				neighborPassage.toggle_wall(-selectedWallDirection,checkState)
		else:
			print("cannot replace exterior wall")
		return
	for neighborPos in neighbors:
		var blockRelative = blockPos - neighborPos
		if (blockRelative not in direction): return
		toggle_wall(blockRelative)

		if !block.parentShip.blocks.get(neighborPos): 
			return
		var neighborBlock = block.parentShip.blocks.get(neighborPos)
		var neighborPassage = neighborBlock.get_node("passage_controller")
		neighborPassage.toggle_wall(-blockRelative,checkState)

func toggle_wall(blockRelative,checkState:bool=false):
	var checkDirection = direction[blockRelative]
	colliders[checkDirection].disabled = !checkState
	walls[checkDirection].visible = checkState

func _on_passage_on_remove() -> void:
	update_walls(true)
