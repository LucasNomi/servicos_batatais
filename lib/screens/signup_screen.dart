import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:servicos_batatais/services/auth_service.dart';
import 'package:servicos_batatais/utils/utils.dart';

import '../utils/colors.dart';
import '../widgets/text_field_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _userName = TextEditingController();
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
    _userName.dispose();
  }

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),
              //TODO: logo
              const SizedBox(
                height: 64,
              ),
              //* circular avatar input
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundColor: Colors.indigo[50],
                          backgroundImage: MemoryImage(_image!),
                        )
                      : CircleAvatar(
                          radius: 64,
                          backgroundColor: Colors.indigo[50],
                          backgroundImage: const NetworkImage(
                              'https://www.pinterest.com/pin/710231803741582825/'),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
              //* username text field
              const SizedBox(
                height: 30,
              ),
              TextFieldInput(
                controller: _userName,
                icon: const Icon(Icons.person),
                hintText: 'Seu nome de usuário aqui',
                inputType: TextInputType.text,
                labelText: 'Usuário',
              ),
              //* text field email
              const SizedBox(
                height: 12,
              ),
              TextFieldInput(
                controller: _email,
                icon: const Icon(Icons.email),
                hintText: 'Seu email aqui',
                inputType: TextInputType.emailAddress,
                labelText: 'Email',
              ),
              //* text field password
              const SizedBox(
                height: 12,
              ),
              TextFieldInput(
                  controller: _password,
                  icon: const Icon(Icons.key),
                  labelText: 'Senha',
                  hintText: 'Sua senha aqui',
                  inputType: TextInputType.text,
                  obscureText: true),
              //TODO: button login
              const SizedBox(
                height: 12,
              ),
              InkWell(
                onTap: () async {
                  String res = await AuthService().signUpUser(
                      email: _email.text,
                      password: _password.text,
                      username: _userName.text,
                      imageUrl: _image!);
                  print(res);
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    color: primaryColor,
                  ),
                  child: const Text(
                    'Cadastrar',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              //TODO: transition to signup
              Flexible(
                flex: 2,
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: const Text('Já possui uma conta?'),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: const Text(
                        ' Efetue o login',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: hightLightColor,
                          fontSize: 14,
                        ),
                      ),
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
}
