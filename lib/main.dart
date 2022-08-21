import 'package:flutter/material.dart';
import 'package:servicos_batatais/responsive/mobile_screen_layout.dart';
import 'package:servicos_batatais/responsive/responsive_layout.dart';
import 'package:servicos_batatais/responsive/web_screen_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Serviços Batatais',
      theme: ThemeData.dark(),
      home: const ResponsiveLayout(
        mobileScreenLayout: MobileScreenLayout(),
        webScreenLayout: WebScreenLayout(),
      ),
    );
  }
}