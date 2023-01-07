import 'package:flutter/material.dart';
import 'package:ludo_app/enums/message_type.dart';
import 'package:ludo_app/resources/socket_methods.dart';
import 'package:ludo_app/responsive/responsive.dart';
import 'package:ludo_app/screens/register_screen.dart';
import 'package:ludo_app/utils/utils.dart';
import 'package:ludo_app/widgets/custom_buttom.dart';
import 'package:ludo_app/widgets/custom_text.dart';
import 'package:ludo_app/widgets/custom_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  loadPreferences() async {}

  @override
  void initState() {
    super.initState();
    loadPreferences();
    _socketMethods.loginSuccessListener(context);
    _socketMethods.errorMessageListener(context);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  validateInputs(BuildContext context) {
    if (_emailController.text.isEmpty) {
      showSnackBar(context, "Ingrese su correo", type: MessageType.warning);
    } else if (_passwordController.text.isEmpty) {
      showSnackBar(context, "Ingrese su contraseña", type: MessageType.warning);
    } else if (!isEmail(_emailController.text)) {
      showSnackBar(context, "Correo no es válido", type: MessageType.warning);
    } else {
      _socketMethods.login(_emailController.text, _passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomText(
                shadows: [
                  Shadow(
                    blurRadius: 40,
                    color: Colors.blue,
                  ),
                ],
                text: 'Ludo App',
                fontSize: 70,
              ),
              SizedBox(height: size.height * 0.08),
              CustomTextField(
                controller: _emailController,
                hintText: 'Ingresa tu correo',
              ),
              SizedBox(height: size.height * 0.03),
              CustomTextField(
                controller: _passwordController,
                hintText: 'Ingresa tu contraseña',
                isPassword: true,
              ),
              SizedBox(height: size.height * 0.045),
              CustomButtom(
                onTap: () => validateInputs(context),
                text: 'Login',
              ),
              SizedBox(height: size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '¿No tienes una cuenta?',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: goToRegister,
                    child: const Text(
                      ' Regístrate',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void goToRegister() {
    Navigator.pushNamed(context, RegisterScreen.routeName);
  }
}
