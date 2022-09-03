import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicos_batatais/screens/profile_screen.dart';

import '../services/job_service.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';
import '../widgets/text_form_field_input.dart';
import '../widgets/ink_well_button.dart';
import '../utils/utils.dart';

class NewJobScreen extends StatefulWidget {
  const NewJobScreen({Key? key}) : super(key: key);

  @override
  State<NewJobScreen> createState() => _NewJobScreenState();
}

class _NewJobScreenState extends State<NewJobScreen> {
  final _formKey = GlobalKey<FormState>();
  final _jobName = TextEditingController();
  final _jobDesc = TextEditingController();
  final _phoneNumber = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _jobName.dispose();
    _jobDesc.dispose();
    _phoneNumber.dispose();
  }

  void postJob(
    String uid,
    String username,
  ) async {
    try {
      if (_formKey.currentState!.validate()) {
        String res = JobService().uploadJob(
            uid, username, _jobName.text, _jobDesc.text, _phoneNumber.text);

        if (res == 'success') {
          showSnackBar('Serviço adicionado', context);
        }
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  void returnScreen() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    MyUser user = Provider.of<UserService>(context).getUser;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(
                    height: 64,
                  ),
                  //* Input job name
                  TextFormFieldInput(
                    controller: _jobName,
                    icon: const Icon(Icons.label),
                    labelText: 'Serviço',
                    hintText: 'Qual o serviço a ser prestado?',
                    inputType: TextInputType.name,
                    validator: validateJobName,
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  //* Input job description
                  TextFormFieldInput(
                    controller: _jobDesc,
                    icon: const Icon(Icons.description),
                    labelText: 'Descrição',
                    hintText: 'Dê alguns detalhes sobre seu serviço',
                    inputType: TextInputType.name,
                    validator: validateJobDesc,
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  //* Input user phonenumber
                  TextFormFieldInput(
                    controller: _phoneNumber,
                    icon: const Icon(Icons.phone),
                    labelText: 'Número',
                    hintText: 'Número para contato',
                    inputType: TextInputType.phone,
                    validator: validatePhoneNumber,
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  //* Button add service
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: InkWellButton(
                      function: () => postJob(user.uid, user.username),
                      children: const [
                        Icon(Icons.add),
                        Text(
                          "Enviar Serviço",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //* Button return to user profile
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: InkWellButton(
                      function: returnScreen,
                      children: const [
                        Text(
                          "Voltar ao perfil",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
