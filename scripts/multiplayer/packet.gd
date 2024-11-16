extends PacketManager.Packet

func run_as_integrated(game_server:GameServer) -> void:
	print(get_object(game_server, "asd", 1))
func run_as_client(game_server:GameServer) -> void:
	pass

func get_object(game_server:GameServer, group_name:String, object_id:int) -> Variant:
	return game_server.object_manager.get_group(group_name).get_object(object_id)
