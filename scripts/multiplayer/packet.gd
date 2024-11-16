class_name GameServerPacket extends Object

# run action as server
func run_as_integrated(game_server:GameServer.Integrated, client_id:int, data:Dictionary) -> void: pass
# run action as client
func run_as_client(game_server:GameServer.Client, data:Dictionary) -> void: pass

# helper functions
func get_object(game_server:GameServer, group_name:String, object_id:int) -> Variant:
	return game_server.object_manager.get_group(group_name).get_object(object_id)
