import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import '../models/user_model.dart';
import '../services/user_provider.dart';
import '../widgets/ink_well_button.dart';
import '../widgets/text_form_field_input.dart';
import '../utils/utils.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  Uint8List? _image;

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  updateProfileData() async {
    if (_formKey.currentState!.validate()) {
      String res = await AuthService()
          .updateProfile(username: _username.text, imageUrl: _image!);

      if (res == "success") {
        showSnackBar('Será atualizado no próximo login', context);
      }
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 64,
                              backgroundColor: Colors.indigo[50],
                              backgroundImage: MemoryImage(_image!),
                            )
                          : CircleAvatar(
                              radius: 64,
                              backgroundColor: Colors.indigo[50],
                              backgroundImage: NetworkImage(user.imageUrl),
                            ),
                      Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                          onPressed: selectImage,
                          icon: const Icon(Icons.add_a_photo),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormFieldInput(
                    controller: _username,
                    icon: const Icon(Icons.person),
                    labelText: 'Usuário',
                    hintText: "Novo nome de usuário",
                    inputType: TextInputType.name,
                    validator: validateUsername,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 15.0),
                    child: InkWellButton(
                      function: updateProfileData,
                      children: const [
                        Text(
                          'Finalizar',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
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
