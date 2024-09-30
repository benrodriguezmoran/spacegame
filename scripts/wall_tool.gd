extends Node
@onready var rayCast = $".."
var placeRotation = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
var doorBool
func check_ray(selectedTool:String):
	if Input.is_action_just_pressed("flipZ"):
		placeRotation += PI/2
	if Input.is_action_just_pressed("flipZ-"):
		placeRotation += -PI/2
	if !rayCast.is_colliding():
		return
	if selectedTool == "door":
		doorBool = true
	else:
		doorBool = false
	if !rayCast.get_collider().get_parent().name == "passage_controller": return
	var passage_controller = rayCast.get_collider().get_parent()
	var wall = rayCast.get_collider()
	if Input.is_action_just_pressed("left_click") and passage_controller and wall != null:
		passage_controller.update_walls(true,wall,doorBool,placeRotation)
	if Input.is_action_just_pressed("right_click") and passage_controller and wall != null:
		passage_controller.update_walls(false,wall,doorBool,placeRotation)
		
func _on_interaction_raycast_transitioned_state(state):
	
	if state == self:
		rayCast.set_collision_mask_value(2, true)
	else:
		rayCast.set_collision_mask_value(2, false)
