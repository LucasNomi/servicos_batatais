import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicos_batatais/my_app.dart';
import 'package:servicos_batatais/firebase_options.dart';
import 'package:servicos_batatais/services/auth_service.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: ((context) => AuthService())),
    ],
    child: const MyApp(),
  ));
}
