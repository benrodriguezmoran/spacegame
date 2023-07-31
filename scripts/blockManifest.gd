extends Node
#Block Manifest



@export var blocks = {
	"structure_block": {
		"scene":preload("res://scenes/parts/structure_block.tscn"),
		"mesh":preload("res://scenes/meshscenes/frame_1x_1.tscn"),
		"size":Vector3(1,1,1),
		"mass":100
		},
	"drive_9m": {
		"scene":preload("res://scenes/parts/drive_9m.tscn"),
		"mesh":preload("res://scenes/meshscenes/drive_3x3.tscn"),
		"size":Vector3(3,3,3),
		"mass":200
		},
	"thruster": {
		"scene":preload("res://scenes/parts/thruster.tscn"),
		"mesh":preload("res://scenes/meshscenes/thruster.tscn"),
		"size":Vector3(1,1,1),
		"mass":500,
		},
	"thruster_5": {
		"scene":preload("res://scenes/parts/thruster_5.tscn"),
		"mesh":preload("res://scenes/meshscenes/thruster5.tscn"),
		"size":Vector3(1,1,1),
		"mass":500,
		}
	}
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
