extends Node
@export var colliders = []
@export var walls = []
@onready var block 
enum {FORE,BACK,LEFT,RIGHT,UP,DOWN}
var direction = {
	"FORE":Vector3(1,0,0),
	"BACK":Vector3(-1,0,0),
	"LEFT":Vector3(0,0,-1),
	"RIGHT":Vector3(0,0,1),
	"UP":Vector3(0,1,0),
	"DOWN":Vector3(0,-1,0),
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
	block.parentShip.connect("block_added", Callable(self, "block_added"))
	
func block_added(placePos):
	var blockPos = block.parentShip.blocks.find_key(block)
	if placePos != blockPos: return
	for child in get_parent().get_children():
		if child is MeshInstance3D:
			walls.append(child)
	colliders = block.colliders
	block.rotation = Vector3(0,0,0)
	neighbors = block.parentShip.get_neighbors(blockPos, block.parentShip.passageDictionary)
	for neighbor in neighbors:
		var neighborBlock = block.parentShip.blocks.get(neighbor)
		var blockRelative = blockPos - neighbor
		print("calling neighbor")
		match blockRelative:
			direction.FORE: 
				print("FORE")
				var checkDirection = FORE
				var invCheck = BACK
				colliders[checkDirection].disabled = true
				walls[checkDirection].visible = false
				neighborBlock.get_node("passage_controller").colliders[invCheck].disabled = true
				neighborBlock.get_node("passage_controller").walls[invCheck].visible = false
			direction.BACK: 
				print("BACK")
				var checkDirection = BACK
				var invCheck = FORE
				colliders[checkDirection].disabled = true
				walls[checkDirection].visible = false
				neighborBlock.get_node("passage_controller").colliders[invCheck].disabled = true
				neighborBlock.get_node("passage_controller").walls[invCheck].visible = false
			direction.LEFT: 
				print("LEFT")
				var checkDirection = LEFT
				var invCheck = RIGHT
				colliders[checkDirection].disabled = true
				walls[checkDirection].visible = false
				neighborBlock.get_node("passage_controller").colliders[invCheck].disabled = true
				neighborBlock.get_node("passage_controller").walls[invCheck].visible = false
			direction.RIGHT: 
				print("RIGHT")
				var checkDirection = RIGHT
				var invCheck = LEFT
				colliders[checkDirection].disabled = true
				walls[checkDirection].visible = false
				neighborBlock.get_node("passage_controller").colliders[invCheck].disabled = true
				neighborBlock.get_node("passage_controller").walls[invCheck].visible = false
			direction.DOWN: 
				print("DOWN")
				var checkDirection = DOWN
				var invCheck = UP
				colliders[checkDirection].disabled = true
				walls[invCheck].visible = false
				neighborBlock.get_node("passage_controller").colliders[invCheck].disabled = true
				neighborBlock.get_node("passage_controller").walls[checkDirection].visible = false
			direction.UP: 
				print("UP")
				var checkDirection = UP
				var invCheck = DOWN
				colliders[checkDirection].disabled = true
				walls[invCheck].visible = false
				neighborBlock.get_node("passage_controller").colliders[invCheck].disabled = true
				neighborBlock.get_node("passage_controller").walls[checkDirection].visible = false
	print(neighbors)
