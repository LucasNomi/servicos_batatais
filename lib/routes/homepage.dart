import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.person_add),
                label: const Text("Cadastrar")),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.login),
              label: const Text("Logar"),
            )
          ],
        ),
      ),
    );
  }
}
