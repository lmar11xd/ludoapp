import 'package:flutter/material.dart';
import 'package:ludo_app/provider/room_data_provider.dart';
import 'package:ludo_app/provider/user_provider.dart';
import 'package:ludo_app/screens/create_room_screen.dart';
import 'package:ludo_app/screens/join_room_screen.dart';
import 'package:ludo_app/screens/login_screen.dart';
import 'package:ludo_app/screens/main_menu_screen.dart';
import 'package:ludo_app/screens/register_screen.dart';
import 'package:ludo_app/utils/colors.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => RoomDataProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: bgColor),
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        MainMenuScreen.routeName: (context) => const MainMenuScreen(),
        CreateRoomScreen.routeName: (context) => const CreateRoomScreen(),
        JoinRoomScreen.routeName: (context) => const JoinRoomScreen()
      },
      initialRoute: LoginScreen.routeName,
    );
  }
}
