import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:servicos_batatais/firebase_options.dart';
import 'package:servicos_batatais/responsive/mobile_screen_layout.dart';
import 'package:servicos_batatais/responsive/responsive_layout.dart';
import 'package:servicos_batatais/responsive/web_screen_layout.dart';
import 'package:servicos_batatais/screens/login_screen.dart';
import 'package:servicos_batatais/screens/signup_screen.dart';
import 'package:servicos_batatais/utils/colors.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      // home: const ResponsiveLayout(
      //   mobileScreenLayout: MobileScreenLayout(),
      //   webScreenLayout: WebScreenLayout(),
      home: const SignUpScreen(),
    );
  }
}
