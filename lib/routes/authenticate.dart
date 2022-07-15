import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  void initState(){
    super.initState();
    bool isSignIn = true;
    Text btnLRLabel = Text('Login');
    Icon IconLR = Icon(Icons.login);
    if(isSignIn == false){
      Text btnLRLabel = Text('Registrar');
      Icon IconLR = Icon(Icons.person_add);
    }
  }


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
            const SizedBox(
              height: 30,
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
            const SizedBox(
              height: 30,
            ),
            ElevatedButton.icon(onPressed: (){}, icon: IconLR, label: btnLRLabel)
          ],
        ),
      ),
    );
  }
}
