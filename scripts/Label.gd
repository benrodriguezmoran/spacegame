extends Label
@onready var player = get_parent().get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var print1 = str(player.placeNormal)
	var print2 = str(player.placeRotation)
	var print3 = str(player.placeTarget)
	var print4 = str(player.acceleration)
	self.text = "%s\n%s\n%s\n%s" % [print1,print2,print3,print4]
