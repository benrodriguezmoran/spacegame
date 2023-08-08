extends Area3D
class_name block_class
var colliders = []
var subblocks = {}
var mass = 0
var type 
var category
var parentShip 

func _init():
	pass

func _ready():
	parentShip = get_parent() if get_parent() is RigidBody3D else get_parent().get_parent()
	for child in get_children():		
		if child is CollisionShape3D && child.name != "BoundingBox":
			colliders.append(child)
			child.reparent.call_deferred(parentShip)

func _process(delta):
	pass
	
func set_type(block_name):
	type = block_name
	mass = blockManifest.blocks[block_name]["mass"]
	category = blockManifest.blocks[block_name]["category"]
	for child in get_children():	
		if child is Area3D:
			child.set_script(load("res://scripts/block.gd"))
			child.type = block_name
			child.mass = blockManifest.blocks[block_name]["mass"]
			child.parentShip = get_parent()
			child.category = blockManifest.blocks[block_name]["category"]

func get_parentship():
	return parentShip
func get_colliders():
	return colliders
func get_subblocks():
	if subblocks.is_empty():
		subblocks[self.position] = self
		for child in get_children():	
			if child is Area3D:
				subblocks[round(child.position / 3)] = child
		for child in get_children():	
			if child is Area3D:
				child.subblocks = subblocks
	return subblocks

func remove():
	for collider in colliders:
		collider.queue_free()
	self.queue_free()

