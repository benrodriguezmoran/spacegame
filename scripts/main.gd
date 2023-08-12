extends Node
@onready var firstship = $"frame/ship"
var mousemode:bool
# Called when the node enters the scene tree for the first time.
func _ready():
	firstship.addBlock(Vector3(0,0,0), Quaternion(0,0,0,1), "structure_block")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	if Input.is_action_just_released("right_click"):
#		mousemode = not mousemode
#		if mousemode:
#			Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
#		else:
#			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass
func _input(input):
	if Input.is_action_just_pressed("toggle_fullscreen"):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN) if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED else DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	if Input.is_action_just_pressed("ui_cancel"): #QUIT
		get_tree().quit()
