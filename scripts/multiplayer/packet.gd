class_name GameServerPacket extends Object

var packet_name:String

# helper functions
func to(data:Variant) -> Dictionary:
	return {
		"packet":packet_name,
		"data":data
	}

func from(data:Dictionary) -> Variant:
	return data["data"]
func get_object(game_server:GameServer, group_name:String, object_id:int) -> Variant:
	return game_server.object_manager.get_group(group_name).get_object(object_id)
