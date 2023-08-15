extends Label
@onready var player = $"../.."
@onready var placer = $"../../interaction_raycast/block_placement"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var print1 = str(Engine.get_frames_per_second())
	var print2 = str(Engine.get_architecture_name())
	var print3 = Vector3i(player.linear_velocity)
	var print4 = placer.placeTarget
	var print5 = placer.placeNormal
	self.text = "%s\n%s\n%s\n%s\n%s" % [print1,print2,print3,print4,print5]
