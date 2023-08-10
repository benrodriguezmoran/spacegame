extends RayCast3D
@export var current_state:Node
@onready var block_placement:Node = $block_placement
var selectedBlock 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_state != null:
		current_state.check_ray(selectedBlock)
	
func _on_player_ui_hotbar_selection(block_name):
	selectedBlock = block_name
	if block_name in blockManifest.blocks.keys():
		current_state = block_placement
