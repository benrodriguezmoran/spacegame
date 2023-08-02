extends RigidBody3D 

var lastSelectedBlock
var totalMass = 0
var blocks = {} #[Vector3 : BlockReference]
var selectedBlock
var highlight
const gridSize:int = 3

func _ready():
	if blocks.is_empty():
		addBlock(Vector3(0,0,0), Quaternion(0,0,0,1), "structure_block")
	center_of_mass_mode = RigidBody3D.CENTER_OF_MASS_MODE_CUSTOM

func _process(delta):
	pass
func _physics_process(delta):
	pass

func preselect(target, normal:Vector3, rot:Quaternion, block_name:String):
	var ref = Vector3i.ZERO
	if (target != null) && (normal != Vector3.ZERO) && (blocks.find_key(target) != null) && (lastSelectedBlock == block_name):
		ref = Vector3(blocks.find_key(target))
		selectedBlock = blockManifest.blocks[block_name]
		var size = selectedBlock.size
		var offsetSize = (normal * transform.basis) * (rot * size) #Offsets placement (ref + (normal * transform.basis * offsetSize) )position to account for block width
		for val in range(3):
			if offsetSize[val] < 0:
				offsetSize[val] = 1
		ref = round(ref + (normal * transform.basis * offsetSize) )
		if has_node("highlight"):
			$highlight.position = ref * gridSize
			$highlight.rotation = rot.get_euler()
		else:
			highlight = selectedBlock.mesh.instantiate()
			add_child(highlight)
	elif has_node("highlight"):
		$highlight.queue_free()
		
	lastSelectedBlock = block_name
	return ref

func addBlock(placePos:Vector3, rot:Quaternion, block_name:String):
	if blocks.has(placePos):
		return
	var newBlockRef = blockManifest.blocks[block_name]
	var newBlock = newBlockRef.scene.instantiate()
	newBlock.set_script(load("res://scripts/block.gd"))
	var tempBlocks = {}
	newBlock.set_type(block_name)
	var newBlockDictionary = newBlock.get_subblocks()
	add_child(newBlock)
	newBlock.position = placePos * gridSize
	newBlock.rotation = rot.get_euler()
	for blockSize in newBlockDictionary:
		var checkPos = round(placePos + (rot * blockSize))
		if blocks.has(checkPos):
			remove_child(newBlock)
			tempBlocks.clear()
			print("Not placed, %s" % [checkPos])
			return
		tempBlocks[checkPos] = newBlockDictionary[blockSize]
	blocks.merge(tempBlocks)
	tempBlocks.clear()
	update_mass()

func remove_block(target) -> void:
	if target == null:
		return
	var targetSubblocks = target.get_subblocks().values()
	for subblock in targetSubblocks:
		blocks.erase(blocks.find_key(subblock))
		subblock.remove()
	update_structure()
	update_mass()

func update_mass():
	var weightedPositions = Vector3.ZERO
	var totalInertia = Vector3.ZERO
	totalMass = 0
	for blockPos in blocks:
		var currentBlock = blocks[blockPos]
		var blockMass = currentBlock.mass
		weightedPositions += (blockPos * gridSize) * blockMass
		totalMass += blockMass
	var centerOfMass = weightedPositions / totalMass 
	for blockPos in blocks:
		var currentBlock = blocks[blockPos]
		var blockMass = currentBlock.mass
		var relativePos = centerOfMass - (blockPos * gridSize) 
		totalInertia.x += blockMass * abs((relativePos.y ** 2) + (relativePos.z ** 2))
		totalInertia.y += blockMass * abs((relativePos.x ** 2) + (relativePos.z ** 2))
		totalInertia.z += blockMass * abs((relativePos.x ** 2) + (relativePos.y ** 2))
	inertia = totalInertia
	mass = totalMass
	center_of_mass = centerOfMass


	
func update_structure():
	var fragments = []
	var checked = []
	var connected:Array
	
	var recursive = func(pos, recursive, firstCall):
		
		if firstCall:
			connected.clear()
		if !checked.has(pos):
			checked.append(pos)
			connected.append(pos)
		var neighbors = get_neighbors(pos)
		for neighbor in neighbors:
			if !checked.has(neighbor):
				recursive.call(neighbor, recursive, false)
		return connected
	var randblock = blocks.keys().pick_random()
	var firstreccall = recursive.call(randblock, recursive, true)
	fragments.append(firstreccall)
	if blocks.size() == checked.size():
		return
	else:
		var notChecked = blocks.keys()
		
		while blocks.size() > checked.size():
			for check in checked:
				notChecked.erase(check)
			var fragment = recursive.call(notChecked.pick_random(), recursive, true)
			fragments.append(fragment)
		print(fragments)
	

func get_neighbors(blockpos):
	var neighbors = []
	for x in [-1,1]:
		var neighbor = blockpos + Vector3(x,0,0)
		if blocks.has(neighbor):
			neighbors.append(neighbor)
	for y in [-1,1]:
		var neighbor = blockpos + Vector3(0,y,0)
		if blocks.has(neighbor):
			neighbors.append(neighbor)
	for z in [-1,1]:
		var neighbor = blockpos + Vector3(0,0,z)
		if blocks.has(neighbor):
			neighbors.append(neighbor)
	return neighbors
			
func get_dictionary():
	return blocks	
		
