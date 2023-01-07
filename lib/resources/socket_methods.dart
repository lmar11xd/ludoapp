import 'package:flutter/material.dart';
import 'package:ludo_app/enums/message_type.dart';
import 'package:ludo_app/provider/user_provider.dart';
import 'package:ludo_app/provider/room_data_provider.dart';
import 'package:ludo_app/resources/socket_client.dart';
import 'package:ludo_app/screens/game_screen.dart';
import 'package:ludo_app/screens/main_menu_screen.dart';
import 'package:ludo_app/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

  Socket get socketClient => _socketClient;

  // EMITS
  void login(String email, String password) {
    _socketClient.emit('login', {'email': email, 'password': password});
  }

  void register(String name, String email, String password) {
    _socketClient.emit('register', {
      'name': name,
      'email': email,
      'password': password,
    });
  }

  void createRoom(String nickName) {
    if (nickName.isNotEmpty) {
      _socketClient.emit('createRoom', {'nickname': nickName});
    }
  }

  // LISTENERS
  void errorMessageListener(BuildContext context) {
    _socketClient.on("errorMessage", (message) {
      showSnackBar(context, message.toString(), type: MessageType.danger);
    });
  }

  void registerSuccessListener(BuildContext context) {
    _socketClient.on("registerSuccess", (user) {
      Provider.of<UserProvider>(context, listen: false).setUserFromMap(user);
      showSnackBar(context, "Usuario registrado.");
      Navigator.pushReplacementNamed(context, MainMenuScreen.routeName);
    });
  }

  void loginSuccessListener(BuildContext context) {
    _socketClient.on("loginSuccess", (user) {
      Provider.of<UserProvider>(context, listen: false).setUserFromMap(user);
      showSnackBar(context, "Usuario logueado.");
      Navigator.pushReplacementNamed(context, MainMenuScreen.routeName);
    });
  }

  void createRoomSuccessListener(BuildContext context) {
    _socketClient.on('createRoomSuccess', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }
}
