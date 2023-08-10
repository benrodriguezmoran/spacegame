extends Node
@export var colliders = []
@export var walls = []
@onready var block = $".."
enum DIRECTION {FORE,BACK,LEFT,RIGHT,UP,DOWN}
var neighbors

# Called when the node enters the scene tree for the first time.
func _ready():
	block.rotation = Vector3(0,0,0)
	var selfBlock = block.parentShip.blocks.find_key(block)
	neighbors = block.parentShip.get_neighbors()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
