extends Label
@onready var block_placer = $"../../block_placer"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var print1 = block_placer.placeTarget
	var print2 = block_placer.targetShip
	var print3 = ""
	var print4 = ""
	self.text = "%s\n%s\n%s\n%s" % [print1,print2,print3,print4]
