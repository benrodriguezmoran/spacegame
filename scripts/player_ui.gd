extends Node

@onready var hotbar = $hotbar
signal hotbar_selection(block_name)
var hotbarSelection =  ["passage", "open", "wall", "door", "passage", "drive_9m" ]
#var dVconsumed = 0
#var acceleration = 0
#var last_vel = 0

func _ready():
	var callable = Callable(self, "on_hotbar_pressed")
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


func on_hotbar_pressed(slot):
	if slot < hotbarSelection.size():
		hotbar_selection.emit(hotbarSelection[slot])


