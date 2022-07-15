import 'package:flutter/material.dart';
import 'package:servicos_batatais/widgets/logo.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _email,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              validator: (String? val) {
                if(val == null || val.isEmpty){
                  return 'Por favor insira um email';
                }else if(!val.contains('@')){
                  return 'Por favor insira um email valido';
                }
                return null;
                },
            ),
            TextFormField(
              controller: _password,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              validator: (String? val){
                if(val == null || val.isEmpty){
                  return 'Por favor insira uma senha';
                }else if(val.length < 8){
                  return 'Senha precisa ter mais que 8 digitos';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
