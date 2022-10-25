import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'services/user_provider.dart';
import '../firebase_options.dart';
import '../layout/layout.dart';
import '../screens/login_screen.dart';
import '../utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //* O main é envolvido por um provedor que notifica mudanças feitas na
    //* autenticação do usuário
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Serviços Batatais',
        theme:
            ThemeData.dark().copyWith(scaffoldBackgroundColor: backgroundColor),
        home: StreamBuilder(
          //* Cria uma stream do artefato "authStateChanges" do firebase para
          //* verificar se o usuário já está logado
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            //* Caso estiver logado o usuário é mandado direto para a página do perfil
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout();
                //* Se houver um erro na stream o erro é mostrado na tela
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
              //* Enquanto a stream não terminar de carregar um indicador
              //* circular é mostrado na tela
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
            //* Se o usuário não estiver logado ele é mandado para a página de login
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
