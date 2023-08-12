extends Node
@export var colliders = []
@export var walls = []
@onready var block 
enum enumDirection {FORE,BACK,LEFT,RIGHT,UP,DOWN}
var direction = {
	Vector3(1,0,0):[enumDirection.FORE,enumDirection.BACK],
	Vector3(-1,0,0):[enumDirection.BACK,enumDirection.FORE],
	Vector3(0,0,-1):[enumDirection.LEFT,enumDirection.RIGHT],
	Vector3(0,0,1):[enumDirection.RIGHT,enumDirection.LEFT],
	Vector3(0,1,0):[enumDirection.UP,enumDirection.DOWN],
	Vector3(0,-1,0):[enumDirection.DOWN,enumDirection.UP],
}
var neighbors

# Called when the node enters the scene tree for the first time.
func _init():
	pass
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_passage_type_set():
	block = get_parent()
	block.parentShip.connect("block_added", Callable(self, "on_block_added"))
	
func on_block_added(placePos):
	var blockPos = block.parentShip.blocks.find_key(block)
	if placePos != blockPos: return
	for child in get_parent().get_children():
		if child is MeshInstance3D:
			walls.append(child)
	colliders = block.colliders
	block.rotation = Vector3(0,0,0)
	neighbors = block.parentShip.get_neighbors(blockPos, block.parentShip.passageDictionary)
	for neighborPos in neighbors:
		var neighborBlock = block.parentShip.blocks.get(neighborPos)
		var blockRelative = blockPos - neighborPos
		var neighborPassage = neighborBlock.get_node("passage_controller")
		if direction.has(blockRelative):
			var checkDirection = direction[blockRelative][0]
			var invCheckDirection = direction[blockRelative][1]
			colliders[checkDirection].disabled = true
			walls[checkDirection].visible = false
			neighborPassage.colliders[invCheckDirection].disabled = true
			neighborPassage.walls[invCheckDirection].visible = false
