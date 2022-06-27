import 'package:flutter/material.dart';

class LogoCorreAqui extends StatelessWidget {
  const LogoCorreAqui({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: const TextSpan(
            text: 'C',
            style: TextStyle(
                color: Colors.blue, fontSize: 46, fontWeight: FontWeight.bold),
            children: [
          TextSpan(
            text: 'orre',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 40,
            ),
          ),
          TextSpan(
            text: 'A',
            style: TextStyle(
                color: Colors.blue, fontSize: 46, fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: 'qui',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 40,
            ),
          ),
        ]));
  }
}
