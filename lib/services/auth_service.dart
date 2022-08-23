import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //TODO: sign up
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required Uint8List imageUrl,
  }) async {
    String res = 'Some error occured!';
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          imageUrl != null) {
        //* register user
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(credential.user!.uid);
        //* add user to database
        await _firestore.collection('users').doc(credential.user!.uid).set({
          'username': username,
          'uid': credential.user!.uid,
          'email': email,
        });
        res = 'success!';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //TODO: login
  loginUser() {}
  //TODO: logout
  signOut() {}
}
