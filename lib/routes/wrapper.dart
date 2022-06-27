import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicos_batatais/routes/authenticate.dart';
import 'package:servicos_batatais/routes/homepage.dart';
import 'package:servicos_batatais/services/auth_service.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    if (auth.isLoading) {
      return Loading();
    } else if (auth.usuario == null) {
      return const Authenticate();
    } else {
      return const HomePage();
    }
  }

  Loading() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
