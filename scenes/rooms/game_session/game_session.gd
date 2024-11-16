class_name GameSession extends Room

var game_server:GameServer
var object_manager:ObjectManager = ObjectManager.new(self)

func _init() -> void:
	# register all game objects & groups
	resource_registry.register_resource(resource_registry.CORE_NAMESPACE, resource_registry.ResourceType.GAME_OBJECT, "avatar", "res://scenes/rooms/game_session/objects/avatar.gd")
	resource_registry.register_resource(resource_registry.CORE_NAMESPACE, resource_registry.ResourceType.GAME_OBJECT_MANAGER_GROUP, "avatar", "res://scenes/rooms/game_session/objects/avatar_group.gd")
	# register all packets
	resource_registry.register_resource(resource_registry.CORE_NAMESPACE, resource_registry.ResourceType.GAME_SERVER_PACKET, "example_packet", "res://scripts/multiplayer/packet.gd")
	
	object_manager.load_groups()
	game_server = GameServer.Integrated.new(object_manager)

func shutdown() -> void:
	game_server.destroy()
	object_manager.destroy()
	resource_registry.clear_types(resource_registry.ResourceType.GAME_OBJECT)
	resource_registry.clear_types(resource_registry.ResourceType.GAME_OBJECT_MANAGER_GROUP)
	resource_registry.clear_types(resource_registry.ResourceType.GAME_SERVER_PACKET)

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed && event.keycode == KEY_ESCAPE:
			room_manager.change_room(
				resource_registry.get_resource_id(resource_registry.CORE_NAMESPACE, resource_registry.ResourceType.ROOM, "main_menu"),
				resource_registry.get_resource_id(resource_registry.CORE_NAMESPACE, resource_registry.ResourceType.ROOM_TRANSITION, "fade"),
				{"color":Color.BLACK},
				func(room:Room)->void: shutdown()
			)
