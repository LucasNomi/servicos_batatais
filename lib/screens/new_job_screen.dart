import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../services/job_service.dart';
import '../models/user_model.dart';
import '../services/user_provider.dart';
import '../widgets/text_form_field_input.dart';
import '../widgets/ink_well_button.dart';
import '../utils/utils.dart';
import '../utils/filters.dart';

class NewJobScreen extends StatefulWidget {
  const NewJobScreen({Key? key}) : super(key: key);

  @override
  State<NewJobScreen> createState() => _NewJobScreenState();
}

class _NewJobScreenState extends State<NewJobScreen> {
  final _formKey = GlobalKey<FormState>();
  final _jobName = TextEditingController();
  String _jobCountryCode = '55';
  final _phoneNumber = TextEditingController();
  String _jobFilter = filters.first;

  @override
  void dispose() {
    super.dispose();
    _jobName.dispose();
    _phoneNumber.dispose();
  }

  void postJob(String uid, String username, String imageUrl) async {
    try {
      if (_formKey.currentState!.validate()) {
        String res = JobService().uploadJob(
          uid,
          username,
          imageUrl,
          _jobName.text,
          _jobCountryCode,
          _jobFilter,
          _phoneNumber.text,
        );
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
    MyUser user = Provider.of<UserProvider>(context).getUser;
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
                  const SizedBox(
                    height: 12.0,
                  ),
                  //* Input user phonenumber
                  IntlPhoneField(
                    controller: _phoneNumber,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.phone),
                      labelText: "Número de telefone",
                      hintText: 'Seu número de telefone aqui',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                    initialCountryCode: 'BR',
                    onCountryChanged: (country) {
                      setState(() {
                        _jobCountryCode = country.code;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  DropdownButton(
                    value: _jobFilter,
                    isExpanded: true,
                    onChanged: (String? value) {
                      setState(() {
                        _jobFilter = value!;
                      });
                    },
                    items:
                        filters.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  //* Button add service
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: InkWellButton(
                      function: () =>
                          postJob(user.uid, user.username, user.imageUrl),
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
