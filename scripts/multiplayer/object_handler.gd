class_name ObjectManager extends Object

var root_node:Node
var serializer:Serializer = Serializer.new()
var _groups:Dictionary

class Group extends Object:
	var name:String
	var serializer: Serializer
	var _objects:Dictionary = {}
	func destroy() -> void: free.call_deferred()
	func _init(s:Serializer) -> void:
		serializer = s
		_register_objects_to_serializer()
	func _register_objects_to_serializer() -> void: pass
	func get_object(object_id: int) -> Object:
		if !_objects.has(object_id):
			push_error("[OM.G]["+name+"]: Did not get find object id of %s" % object_id)
			return null
		return _objects[object_id]
	func remove(object_id: int) -> void: 
		if !_objects.has(object_id):
			push_error("[OM.G]["+name+"]: Did not remove find object id of %s" % object_id)
		else:
			_objects.erase(object_id)
	func add(object_id: int) -> void:
		if _objects.has(object_id):
			push_error("[OM.G]["+name+"]: Tried to add a object with same id %s" % object_id)
		else:
			_objects[object_id] = _create_object(object_id)
	func _create_object(_object_id: int) -> Object: return
	func to_dict() -> Dictionary:
		var total_dict:Dictionary = {}
		for object_id:int in _objects:
			total_dict[object_id] = serializer.to(_objects[object_id])
		return total_dict
	func from_dict(data:Dictionary) -> void:
		for object_id:int in data:
			var object_data:Dictionary = data[object_id]
			var object:Object
			if _objects.has(object_id):
				object = _objects[object_id]
			else:
				object = _create_object(object_id)
			serializer.from(object, object_data)

func _init(set_root_node:Node) -> void:
	root_node = set_root_node

func load_groups() -> void:
	for resource_id:String in resource_registry.get_resources_by_type(resource_registry.ResourceType.GAME_OBJECT_MANAGER_GROUP):
		var resource:Resource = resource_registry.get_resource(resource_id)
		if resource is GDScript:
			_groups[resource_registry.localize_resource(resource_id)] = resource.new(serializer)

func register_group(group_name:String, group:Group) -> void:
	_groups[group_name] = group
	group.name = group_name

func get_group(group_name: String) -> Group:
	if !_groups.has(group_name):
		push_error("[OM]: Group not found in group registry: %s" % group_name)
		return
	return _groups[group_name]

func destroy() -> void:
	for group_name:String in _groups:
		var group:Group = _groups[group_name]
		group.destroy()
	serializer.destroy()
	free.call_deferred()
