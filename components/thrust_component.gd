extends Node3D
var block

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_thruster_type_set() -> void:
	block = get_parent()
	block.parentShip.connect("block_added", Callable(self, "_on_block_added"))
