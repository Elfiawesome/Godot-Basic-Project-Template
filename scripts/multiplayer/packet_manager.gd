class_name PacketManager extends Object

var _packets:Dictionary = {}

class Packet extends Object:pass

func load_packets() -> void:
	for resource_id:String in resource_registry.get_resources_by_type(resource_registry.ResourceType.GAME_SERVER_PACKET):
		var resource:Resource = resource_registry.get_resource(resource_id)
		if resource is GDScript:
			_packets[resource_registry.localize_resource(resource_id)] = resource.new()

func register_packet(packet_name:String, packet:Packet) -> void:
	_packets[packet_name] = packet

func get_packet(packet_name: String) -> Packet:
	return _packets[packet_name]

func destroy() -> void:
	free.call_deferred()
