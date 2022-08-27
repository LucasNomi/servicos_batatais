import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:servicos_batatais/services/storage_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //* sign up com storage
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required Uint8List imageUrl,
  }) async {
    String result = 'Some error occurred';
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          imageUrl != null) {
        //* register user
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String url = await StorageService()
            .uploadImagetoStorage("profilePics", imageUrl, false);

        //* add user to database
        await _firestore.collection('users').doc(credential.user!.uid).set({
          'username': username,
          'uid': credential.user!.uid,
          'email': email,
          'imageUrl': url,
        });

        result = 'success';
      }
    } on FirebaseAuthException catch (e) {
      result = e.message!;
    }
    return result;
  }

  //TODO: login
  loginUser() {}
  //TODO: logout
  signOut() {}
}
