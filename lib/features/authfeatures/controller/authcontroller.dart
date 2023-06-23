// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:financhio/features/authfeatures/repositoris/auth_repo.dart';

final authControllerProvider=Provider((ref){
  final authRepository=ref.watch(authRepositoryProvider);
  return AuthController(authRepository:authRepository,ref: ref );
});

//all provider in riverpod have to be global.


class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;

  AuthController({
    required this.authRepository,
    required this.ref,
  });
  void SignUpWithMail(
      BuildContext context, String name, String email, String password) {
    authRepository.SignUpUser(name, email, password, context);
  }
  void LoginUser(String email,String password,BuildContext context){
    authRepository.SignInUser(email, password, context);
  }
  void saveUserDataToFirebase(BuildContext context,String name,File profilePic){
    authRepository.SaveUserDataToFirestore(name: name, profilePic: profilePic, ref: ref, context: context);
  }
}
