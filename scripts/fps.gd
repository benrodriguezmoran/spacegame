extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var print1 = str(Engine.get_frames_per_second())
	var print2 = ""
	var print3 = ""
	var print4 = ""
	self.text = "%s\n%s\n%s\n%s" % [print1,print2,print3,print4]
