extends Node3D
@export var colliders = []
@export var walls = []
@onready var block 
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
		if child is Area3D:
			wallInteractors.append(child)
	for wall in wallInteractors:
		wallVectors[wall] = direction.keys()[wallInteractors.find(wall)] 
	colliders = block.colliders
	block.rotation = Vector3(0,0,0)
	check_walls()

func check_walls():
	neighbors = block.parentShip.get_neighbors(blockPos, block.parentShip.passageDictionary)
	for neighborPos in neighbors:
		var neighborBlock = block.parentShip.blocks.get(neighborPos)
		var blockRelative = blockPos - neighborPos
		var neighborPassage = neighborBlock.get_node("passage_controller")
		if direction.has(blockRelative):
			toggle_wall(blockRelative)
			neighborPassage.toggle_wall(-blockRelative)

func toggle_wall(blockRelative,checkState:bool=false):
	var checkDirection = direction[blockRelative]
	colliders[checkDirection].disabled = !checkState
	walls[checkDirection].visible = checkState

