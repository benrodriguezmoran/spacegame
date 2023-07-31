extends Node

@onready var hotbar = $hotbar
signal block_selection(block_name)
var hotbarSelection =  ["structure_block", "thruster", "thruster_5", "drive_9m" ]
#var dVconsumed = 0
#var acceleration = 0
#var last_vel = 0

func _ready():
	var callable = Callable(self, "on_button_pressed")
	var iteration = 0
	for button in hotbar.get_children():
		button.connect("pressed", callable.bind(iteration))
		iteration += 1


func _process(delta):
#
#		acceleration = abs(linear_velocity.length()-last_vel)
#		dVconsumed += acceleration
#		last_vel = linear_velocity.length()
#
	pass
func _input(event):
	pass


func on_button_pressed(slot):
	if slot < hotbarSelection.size():
		block_selection.emit(hotbarSelection[slot])


