import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

import '../screens/login_screen.dart';
import '../services/auth_service.dart';
import '../utils/utils.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/colors.dart';
import '../widgets/text_form_field_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _userName = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

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

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    try {
      if (_formKey.currentState!.validate()) {
        String res = await AuthService().signUpUser(
            email: _email.text,
            password: _password.text,
            username: _userName.text,
            imageUrl: _image!);

        if (res == 'success') {
          navHomeScreen();
        }
      }
    } on AuthException catch (e) {
      showSnackBar(e.message, context);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void navHomeScreen() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const ResponsiveLayout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout())));
  }

  void navLogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                              backgroundImage:
                                  const AssetImage('assets/nopfp.png'),
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
                  TextFormFieldInput(
                    controller: _userName,
                    icon: const Icon(Icons.person),
                    hintText: 'Seu nome de usuário aqui',
                    inputType: TextInputType.text,
                    labelText: 'Usuário',
                    validator: validateUsername,
                  ),
                  //* text field email
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormFieldInput(
                    controller: _email,
                    icon: const Icon(Icons.email),
                    hintText: 'Seu email aqui',
                    inputType: TextInputType.emailAddress,
                    labelText: 'Email',
                    validator: validateEmail,
                  ),
                  //* text field password
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormFieldInput(
                    controller: _password,
                    icon: const Icon(Icons.key),
                    labelText: 'Senha',
                    hintText: 'Sua senha aqui',
                    inputType: TextInputType.text,
                    obscureText: true,
                    validator: validatePassword,
                  ),
                  //* button signup
                  const SizedBox(
                    height: 12,
                  ),
                  InkWell(
                    onTap: signUpUser,
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
                      child: _isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : const Text(
                              'Cadastrar',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                    ),
                  ),
                  //TODO: transition to signup
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: const Text('Já possui uma conta?'),
                      ),
                      GestureDetector(
                        onTap: navLogin,
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
        ),
      ),
    );
  }
}
