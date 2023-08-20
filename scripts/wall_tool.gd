extends Node
@onready var rayCast = $".."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func check_ray(selectedTool:String):
	if !rayCast.is_colliding():
		return
	


func _on_interaction_raycast_transitioned_state(state):
	if state == self:
		rayCast.set_collision_mask_value(2, true)
	else:
		rayCast.set_collision_mask_value(2, false)
