import 'package:flutter/material.dart';

void main() {
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(children: [
          RichText(
            text: const TextSpan(
                text: 'C',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 28),
                children: <TextSpan>[
                  TextSpan(
                    text: 'orre',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white70,
                    ),
                  ),
                  TextSpan(
                    text: 'A',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 28),
                  ),
                  TextSpan(
                    text: 'qui',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white70,
                    ),
                  ),
                ]),
          )
        ]),
      ),
    );
  }
}
