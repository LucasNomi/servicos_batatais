import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:servicos_batatais/routes/homepage.dart';
import 'package:servicos_batatais/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:servicos_batatais/widgets/logo.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  registrar() async {
    try {
      await context
          .read<AuthService>()
          .registrar(_emailController.text, _passwordController.text);
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(130, 195, 195, 195),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const LogoCorreAqui(),
                const SizedBox(
                  height: 50.0,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: 'Entre um email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Entre um email';
                    } else if (val.length < 6) {
                      return 'Email precisa ser maior que 6 caracteres';
                    } else if (!val.contains('@')) {
                      return 'Email não é válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    hintText: 'Entre uma senha',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Entre uma senha';
                    } else if (val.length < 10) {
                      return 'Senha precisa ser maior que 10 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        registrar();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const HomePage()));
                      }
                    },
                    icon: const Icon(Icons.email),
                    label: const Text('CADASTRAR EMAIL')),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                    icon: const FaIcon(FontAwesomeIcons.google),
                    label: const Text('CADASTRAR GOOGLE')),
              ],
            ),
          ),
        ));
  }
}
