import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:servicos_batatais/services/storage_service.dart';

class AuthException implements Exception {
  String message;

  AuthException(this.message);
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? usuario;

  //* get user after login, sign up and signout
  _getUser() {
    usuario = _auth.currentUser;
  }

  //* sign up com storage
  signUpUser({
    required String email,
    required String password,
    required String username,
    required Uint8List imageUrl,
  }) async {
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

        _getUser();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw AuthException('Email já cadastrado');
      }
    }
  }

  //TODO: login
  loginUser() {}
  //TODO: logout
  signOut() {}
}
