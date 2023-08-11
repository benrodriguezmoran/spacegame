extends Node
@export var colliders = []
@export var walls = []
@onready var block 
enum DIRECTION {FORE,BACK,LEFT,RIGHT,UP,DOWN}
var directionDictionary = {
	DIRECTION.FORE:Vector3(1,0,0),
	DIRECTION.BACK:Vector3(-1,0,0),
	DIRECTION.LEFT:Vector3(0,0,-1),
	DIRECTION.RIGHT:Vector3(0,0,1),
	DIRECTION.UP:Vector3(0,1,0),
	DIRECTION.DOWN:Vector3(0,-1,0),
}
var neighbors

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_passage_type_set():
	block = get_parent()
	block.parentShip.connect("block_added", Callable(self, "block_added"))
	
func block_added(placePos):
	
	var blockPos = block.parentShip.blocks.find_key(block)
	if placePos != blockPos: return
	neighbors = block.parentShip.get_neighbors(blockPos)
	for neighbor in neighbors:
		var neighborBlock = block.parentShip.blocks.get(neighbor)
		if neighborBlock.category == "passage":
			print("passage")
	print(neighbors)
