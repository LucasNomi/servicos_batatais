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
