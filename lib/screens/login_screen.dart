import 'package:flutter/material.dart';
import 'package:servicos_batatais/screens/signup_screen.dart';
import 'package:servicos_batatais/services/auth_service.dart';

import '../utils/colors.dart';
import '../utils/utils.dart';
import '../layout/layout.dart';
import '../widgets/text_form_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (_formKey.currentState!.validate()) {
        String res = await AuthService()
            .loginUser(email: _email.text, password: _password.text);

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
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const ResponsiveLayout()));
  }

  void navSignUp() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SignUpScreen()));
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
                  //* text field email
                  const SizedBox(
                    height: 64,
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
                  ),
                  //* button login
                  const SizedBox(
                    height: 12,
                  ),
                  InkWell(
                    onTap: loginUser,
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
                              'Entrar',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                    ),
                  ),
                  //* transition to signup
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: const Text('Ainda não possui uma conta?'),
                      ),
                      GestureDetector(
                        onTap: navSignUp,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: const Text(
                            ' Registre-se',
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
