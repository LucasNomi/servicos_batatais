import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _imageUrl = await _imagePicker.pickImage(source: source);

  if (_imageUrl != null) {
    return await _imageUrl.readAsBytes();
  } else {
    print("No image Selected");
  }
}

String? validateUsername(String? formUsername) {
  if (formUsername == null || formUsername.isEmpty) {
    return 'Um nome de usuário é necessário';
  }
  return null;
}

String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty) {
    return 'Um e-mail é necessário';
  }

  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formEmail)) {
    return 'O e-mail é inválido';
  }

  return null;
}

String? validatePassword(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty) {
    return 'Uma senha é necessária';
  }

  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formPassword)) {
    return '''
      Senha precisa ser de no mínimo 6 caracteres,
      Inclua: Uma letra maiúscula, número e símbolo.
      ''';
  }
  return null;
}
