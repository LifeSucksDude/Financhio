// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financhio/common/utils/utils.dart';
import 'package:financhio/features/authfeatures/views/loginPageView.dart';
import 'package:financhio/homeview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);
final authProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthRepository({required this.auth, required this.firestore});
  
  void SignUpUser(
      String name, String email, String password, BuildContext context) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
          showSnackBar(context: context, content: "Signed in");
      Navigator.push(context, LoginPageView.route());
      
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message!);
    }
  }

  void SignInUser(String email, String password, BuildContext context) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
       showSnackBar(context: context, content: "logged in");
      Navigator.push(context, HomePage.route());
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message!);
    }
  }
 

}
