# Godot Basic Project Template

A foundational project template for Godot 4.3, designed to streamline your game development process.

## ✨ Features

- **Advanced Room Switching**: Seamless transitions between rooms. [Learn more](scenes/room_manager.gd)
- **Global Resource Registry System**: Centralized resource management. [Learn more](scripts/global/resource_registry.gd)
- **Integrated Server-Client Networking**: Built-in server-client system via GameServer. [Learn more](scripts/multiplayer/game_server.gd)

## 🌱 Networking System

Designed to emulate the networking system of many LAN games, this integrated server and player system operates within a single game instance, giving rise to the GameServer.

## 📜 Code Overview

### GameServer

The `GameServer` class manages the core networking functionality. It includes two subclasses:

1. **Integrated**: This subclass handles server-side operations. It manages client connections, broadcasts data to clients, and processes server logic. Key functions include:
   - `generate_object_id()`: Generates unique object IDs.
   - `connect_to_server()`: Establishes a connection to the server and sets up event handlers for client connections, disconnections, and data reception.
   - `client_requested_connection()`: Manages client connection requests.
   - `_on_client_connected()`, `_on_client_disconnected()`, `_on_data_received()`: Handle client connection events and data reception.
   - `send_data()`, `broadcast_all_data()`, `broadcast_specific_data()`: Send data to specific clients or broadcast to all clients.
   - `run_packet()`: Executes a packet's logic on the server side.

2. **Client**: This subclass manages client-side operations. It connects to the server, handles data reception, and sends data to the server. Key functions include:
   - `connect_to_server()`: Establishes a connection to the server and sets up event handlers for connection success, failure, and data reception.
   - `_on_data_received()`: Handles data reception from the server.
   - `send_data()`: Sends data to the server.
   - `run_packet()`: Executes a packet's logic on the client side.

### GameServerPacket

The `GameServerPacket` class defines the structure and behavior of packets exchanged between the server and clients. It includes methods for processing server logic, broadcasting to clients, and running locally. Key components include:

- **Payload**: A nested class that represents the data structure of a packet. It includes methods to convert the payload to and from a dictionary. A custom payload can be declared in the packet and set through `_initialize_packet_payload_type()`.
- `run_as_integrated()`: Executes the packet's logic on the server side, processes server logic, and broadcasts the packet to clients.
- `run_as_client()`: Executes the packet's logic on the client side and sends a request to the server.
- `run_locally()`: Executes the packet's logic on both the client and server sides.
- Helper functions like `to_dict()`, `form_dict()`, and `get_object()` to manage packet data and retrieve game objects.

### ObjectManager

The `ObjectManager` class manages game objects and groups, providing methods for loading, registering, and retrieving groups.

### GameSession

The `GameSession` is part of the `Room` class. It initializes both game server and object manager. GameSession can be left alone if there are no multiplayer/networking in the game. It also handles the registration and unregistration of game objects and groups from the `resource_registry` system.

---

### How It All Works Together

1. **Initialization**: The `GameSession` class initializes the `GameServer` and `ObjectManager`. It registers game objects and groups, and loads them into the `ObjectManager`.

2. **Connecting to the Server**: The `GameServer` (either `Integrated` or `Client`) establishes a connection to the server. The `Integrated` server handles client connections and manages data broadcasting, while the `Client` connects to the server and handles data reception.

3. **Packet Management**: The `GameServerPacket` class manages the packets exchanged between the server and clients. When a packet is received, it is processed by the appropriate method (`run_as_integrated`, `run_as_client`, or `run_locally`), depending on whether it is being handled by the server or client.

4. **Data Transmission**: The `GameServer` sends and receives data through its `send_data`, `broadcast_all_data`, and `broadcast_specific_data` methods. These methods ensure that data is transmitted efficiently between the server and clients.

5. **Object Management**: The `ObjectManager` class manages game objects and groups, providing methods for loading, registering, and retrieving groups. This ensures that all game objects are properly managed and accessible throughout the game session.

By combining these components, your game can achieve a robust and efficient networking system that supports both server and client operations seamlessly.
