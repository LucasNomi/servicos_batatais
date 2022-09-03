import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';
import '../services/storage_service.dart';

class AuthException implements Exception {
  String message;

  AuthException(this.message);
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //* get details from users db
  Future<MyUser> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return MyUser.fromSnap(snap);
  }

  //* sign up com storage
  signUpUser({
    required String email,
    required String password,
    required String username,
    required Uint8List imageUrl,
  }) async {
    String res = 'Some error occurred';
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          imageUrl != null) {
        //* register user
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String url = await StorageService()
            .uploadImagetoStorage("profilePics", imageUrl);

        //* creating user
        MyUser user = MyUser(
            uid: credential.user!.uid,
            email: email,
            username: username,
            imageUrl: url);

        //* add user to database
        await _firestore
            .collection('users')
            .doc(credential.user!.uid)
            .set(user.toJson());
        res = 'success';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw AuthException('Email já cadastrado');
      }
    }
    return res;
  }

  //* login
  loginUser({
    required String email,
    required String password,
  }) async {
    String res = 'Some error occurred';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        //* login user
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      }
      res = 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('Usuário não cadastrado');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta');
      }
    }
    return res;
  }

  //* signout
  signOut() async {
    await _auth.signOut();
  }
}
