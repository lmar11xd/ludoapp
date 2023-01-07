import 'package:flutter/material.dart';
import 'package:ludo_app/provider/user_provider.dart';
import 'package:ludo_app/responsive/responsive.dart';
import 'package:ludo_app/widgets/custom_buttom.dart';
import 'package:ludo_app/widgets/custom_text.dart';
import 'package:ludo_app/widgets/profile_widget.dart';
import 'package:provider/provider.dart';

import 'create_room_screen.dart';
import 'join_room_screen.dart';

class MainMenuScreen extends StatelessWidget {
  static String routeName = '/main-menu';
  const MainMenuScreen({Key? key}) : super(key: key);

  void createRoom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoomScreen.routeName);
  }

  void joinRoom(BuildContext context) {
    Navigator.pushNamed(context, JoinRoomScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: Responsive(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              const SizedBox(height: 40),
              ProfileWidget(
                imagePath: '',
                isEdit: true,
                onClicked: () {},
              ),
              const SizedBox(height: 10),
              buildName(userProvider.user.name),
              Text(
                userProvider.user.email,
                style: const TextStyle(color: Colors.white60),
              ),
              Expanded(child: Container()),
              const SizedBox(height: 20),
              CustomButtom(
                  onTap: () => createRoom(context), text: 'Crear Sala'),
              const SizedBox(height: 10),
              CustomButtom(onTap: () => joinRoom(context), text: 'Unirme'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildName(String name) {
    return CustomText(
      shadows: const [
        Shadow(
          blurRadius: 40,
          color: Colors.blue,
        ),
      ],
      text: name,
      fontSize: 28,
    );
  }
}
