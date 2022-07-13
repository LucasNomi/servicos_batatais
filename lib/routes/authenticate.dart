import 'package:flutter/material.dart';
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
          ],
        ),
      ),
    );
  }
}
