extends RayCast3D
@export var current_state:Node
@onready var block_placement:Node = $block_placement
@onready var wall_tool:Node = $wall_tool
@onready var prop_placement: Node = $prop_placement

var selectedTool:String
signal transitioned_state(state)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_state != null:
		current_state.check_ray(selectedTool)
	
func _on_player_ui_hotbar_selection(toolName):
	
	if toolName in blockManifest.blocks.keys():
		print(toolName)
		selectedTool = toolName
		current_state = block_placement
		emit_signal("transitioned_state", block_placement)
	if toolName in blockManifest.tools:
		print(toolName)
		selectedTool = toolName
		current_state = wall_tool
		emit_signal("transitioned_state", wall_tool)
	if toolName in blockManifest.props:
		print(toolName)
		selectedTool = toolName
		current_state = wall_tool
		emit_signal("transitioned_state", wall_tool)
