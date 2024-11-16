class_name GameServer extends Object

var object_manager:ObjectManager
var packet_manager:PacketManager = PacketManager.new()

class Integrated extends GameServer:
	var _next_object_id:int = 0
	func generate_object_id() -> int:
		_next_object_id += 1
		return _next_object_id
	
	func run_packet(packet_name:String, client_id:int, packet_data:Dictionary) -> void:
		var packet := packet_manager.get_packet(packet_name)
		if packet == null: return
		packet.run_as_integrated(self, 0, packet_data)
class Client extends GameServer:
	func run_packet(packet_name:String, packet_data:Dictionary) -> void:
		var packet := packet_manager.get_packet(packet_name)
		if packet == null: return
		packet.run_as_client(self, packet_data)

func _init(new_object_manager:ObjectManager) -> void:
	object_manager = new_object_manager
	packet_manager.load_packets()


func destroy() -> void:
	packet_manager.destroy()
	free.call_deferred()
