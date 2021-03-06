import 'package:flutter/material.dart';
import 'package:servicos_batatais/routes/sign_in.dart';
import 'package:servicos_batatais/routes/sign_up.dart';
import 'package:servicos_batatais/widgets/logo.dart';

class Authenticate extends StatelessWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(130, 195, 195, 195),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LogoCorreAqui(),
            const SizedBox(
              height: 50.0,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const SignUp()));
                },
                icon: const Icon(Icons.person_add),
                label: const Text("Cadastrar")),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const SignIn()));
              },
              icon: const Icon(Icons.login),
              label: const Text("Logar"),
            )
          ],
        ),
      ),
    );
  }
}
