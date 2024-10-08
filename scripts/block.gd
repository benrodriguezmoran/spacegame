extends Area3D
class_name block_class
var colliders = []
var subblocks = {}
var mass = 0
var type 
var isMainMultiblock = true
var category
var parentShip 
signal type_set
signal on_remove
func _init():
	self.set_meta("block", true)

func _ready():
	pass

func _process(delta):
	pass
	
func set_type(block_name, parent:Node):
	parentShip = parent
	type = block_name
	mass = blockManifest.blocks[block_name]["mass"]
	category = blockManifest.blocks[block_name]["category"]
	for child in get_children():
		if child is CollisionShape3D && child.name != "BoundingBox":
			colliders.append(child)
			child.reparent.call_deferred(parent)
		if child is Area3D:
			child.set_script(load("res://scripts/block.gd"))
			child.type = block_name
			child.mass = blockManifest.blocks[block_name]["mass"]
			child.isMainMultiblock = false
			child.parentShip = parent
			child.category = blockManifest.blocks[block_name]["category"]
			child.reparent.call_deferred(parent)
	emit_signal("type_set")

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
	emit_signal("on_remove")
	for collider in colliders:
		collider.queue_free()
	for subblock in subblocks:
		subblocks[subblock].queue_free()
	self.queue_free()
