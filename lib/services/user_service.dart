import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../models/user_model.dart';

class UserService with ChangeNotifier {
  final AuthService _auth = AuthService();
  MyUser? _user;

  MyUser get getUser => _user!;

  Future<void> refreshUser() async {
    MyUser user = await _auth.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
