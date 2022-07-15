import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isSignIn = true;
  late Text btnLRLabel;
  late Icon iconLR;
  late Text btnChangeAuth;

  @override
  void initState() {
    super.initState();
    setFormAction(true);
  }

  setFormAction(bool acao) {
    setState(() {
      isSignIn = acao;
      if (isSignIn == true) {
        btnLRLabel = Text('Login');
        iconLR = Icon(Icons.login);
        btnChangeAuth = Text('Ainda não possuí uma conta? Cadastre-se!');
      } else {
        btnLRLabel = Text('Cadastrar');
        iconLR = Icon(Icons.person_add);
        btnChangeAuth = Text('Já possuí uma conta? Efetue o login!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                  if (val == null || val.isEmpty) {
                    return 'Por favor insira um email';
                  } else if (!val.contains('@')) {
                    return 'Por favor insira um email valido';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 30.0,
              ),
              TextFormField(
                controller: _password,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (String? val) {
                  if (val == null || val.isEmpty) {
                    return 'Por favor insira uma senha';
                  } else if (val.length < 8) {
                    return 'Senha precisa ter mais que 8 digitos';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 30.0,
              ),
              ElevatedButton.icon(
                  onPressed: () {}, icon: iconLR, label: btnLRLabel),
              const SizedBox(
                height: 50.0,
              ),
              TextButton(
                  onPressed: () => setFormAction(!isSignIn),
                  child: btnChangeAuth),
            ],
          ),
        ),
      ),
    );
  }
}
