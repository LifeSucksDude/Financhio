import 'package:financhio/features/authfeatures/repositoris/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider=Provider((ref){
  final authRepository=ref.watch(authRepositoryProvider);
  return AuthController(authRepository:authRepository );
});

//all provider in riverpod have to be global.


class AuthController {
  final AuthRepository authRepository;

  AuthController({required this.authRepository});
  void SignUpWithMail(
      BuildContext context, String name, String email, String password) {
    authRepository.SignUpUser(name, email, password, context);
  }
  void LoginUser(String email,String password,BuildContext context){
    authRepository.SignInUser(email, password, context);
  }
}
