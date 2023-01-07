import 'package:flutter/material.dart';
import 'package:ludo_app/enums/message_type.dart';
import 'package:ludo_app/resources/socket_methods.dart';
import 'package:ludo_app/utils/utils.dart';
import 'package:ludo_app/widgets/app_bar.dart';
import 'package:ludo_app/widgets/custom_buttom.dart';
import 'package:ludo_app/widgets/custom_textfield.dart';
import 'package:ludo_app/widgets/profile_widget.dart';

class RegisterScreen extends StatefulWidget {
  static String routeName = '/register';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.errorMessageListener(context);
    _socketMethods.registerSuccessListener(context);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _password2Controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: '',
            isEdit: false,
            onClicked: () async {},
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: _nameController,
            hintText: 'Nombres',
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: _emailController,
            hintText: 'Correo',
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: _passwordController,
            isPassword: true,
            hintText: 'Contraseña',
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: _password2Controller,
            isPassword: true,
            hintText: 'Repetir Contraseña',
          ),
          const SizedBox(height: 20),
          CustomButtom(
            onTap: () => validateInputs(context),
            text: 'Registrar',
          ),
        ],
      ),
    );
  }

  validateInputs(BuildContext context) {
    if (_nameController.text.isEmpty) {
      showSnackBar(context, "Ingrese su nombre", type: MessageType.warning);
    } else if (_emailController.text.isEmpty) {
      showSnackBar(context, "Ingrese su correo", type: MessageType.warning);
    } else if (!isEmail(_emailController.text)) {
      showSnackBar(context, "Correo no es válido", type: MessageType.warning);
    } else if (_passwordController.text.isEmpty) {
      showSnackBar(context, "Ingrese su contraseña", type: MessageType.warning);
    } else if (_password2Controller.text.isEmpty) {
      showSnackBar(context, "Repita su contraseña", type: MessageType.warning);
    } else if (_passwordController.text != _password2Controller.text) {
      showSnackBar(context, "Las contraseñas no son iguales",
          type: MessageType.warning);
    } else {
      _socketMethods.register(_nameController.text, _emailController.text,
          _passwordController.text);
    }
  }
}
