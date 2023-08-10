extends Node
#Block Manifest


@export var block_categories = ["structure","drive","thruster","control","tank","passage"]
@export var blocks = {
	"structure_block": {
		"scene":preload("res://scenes/parts/structure_block.tscn"),
		"mesh":preload("res://scenes/meshscenes/frame_1x_1.tscn"),
		"size":Vector3(1,1,1),
		"mass":100,
		"category":"structure",
		},
	"drive_9m": {
		"scene":preload("res://scenes/parts/drive_9m.tscn"),
		"mesh":preload("res://scenes/meshscenes/drive_3x3.tscn"),
		"size":Vector3(3,5,3),
		"mass":200,
		"category":"drive",
		},
	"thruster": {
		"scene":preload("res://scenes/parts/thruster.tscn"),
		"mesh":preload("res://scenes/meshscenes/thruster.tscn"),
		"size":Vector3(1,1,1),
		"mass":500,
		"category":"thruster",
		},
	"thruster_5": {
		"scene":preload("res://scenes/parts/thruster_5.tscn"),
		"mesh":preload("res://scenes/meshscenes/thruster5.tscn"),
		"size":Vector3(1,1,1),
		"mass":500,
		"category":"thruster",
		},
	"passage": {
		"scene":preload("res://scenes/parts/passage.tscn"),
		"mesh":preload("res://scenes/meshscenes/passage.tscn"),
		"size":Vector3(1,1,1),
		"mass":200,
		"category":"passage",
		}
	}
@export var tools = ["wall","door"]
#@export var props = {
#	"control_seat":{
#		"scene":preload("res://scenes/props/control_seat.tscn"),
#		"mesh":preload("res://scenes/meshscenes/control_seat.tscn"),
#		"category":"control"
#	}
#}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func get_block(strName):
	return blocks.get(strName)
func get_mass(strName):
	return blocks.get(strName)["mass"]
func get_type(scene):
	return blocks.find_key(scene)
func get_block_names():
	return blocks.keys()
