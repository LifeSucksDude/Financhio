// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financhio/common/reposititories/common_firebase_storage_repository.dart';
import 'package:financhio/common/utils/utils.dart';
import 'package:financhio/features/authfeatures/views/loginPageView.dart';
import 'package:financhio/features/forAddingProfile/addAccount.dart';
import 'package:financhio/features/forAddingProfile/addProfile.dart';

import 'package:financhio/models/userModel.dart';
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
  Future<UserModel?> getCurrentUserData()async{
   var userData=  await firestore.collection('users').doc(auth.currentUser?.uid).get();
   UserModel? user;
   if(userData.data()!=null){
   user=UserModel.fromMap(userData.data()!);
   }
   return user;
  }

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
      Navigator.push(context, UserInformation.route());
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message!);
    }
  }

  void SaveUserDataToFirestore({
    required String name,
    required File? profilePic,
    required ProviderRef ref,
    required BuildContext context,
  }) async {
    try {
      String uid = auth.currentUser!
          .uid; //i can't be null because of the navigation of the app pages
      String photoUrl = "https://source.unsplash.com/user/wsanter";
      if (profilePic != null) {
        photoUrl = await ref
            .read(commonFirebaseStorageProvider)
            .storeFiletoFirebase('profilePic/$uid', profilePic);
      }
      var user = UserModel(
          name: name,
          uid: uid,
          profilePic: photoUrl,
         
          email: auth.currentUser!.uid);

      await firestore.collection('users').doc(uid).set(user.toMap());
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => AddListofBankName()),
          (route) => false);
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
   addBankCollection(String bankName,String description,String currBalance,BuildContext context)async{
    try{
       String uid = auth.currentUser!.uid;
    
        CollectionReference usersCollection = firestore.collection('users');
         await usersCollection.doc(uid).collection('banks').doc(bankName).set({'description':description,
         'currentBalance':currBalance});

    }
    catch(e){
     showSnackBar(context: context, content:e.toString());
    }
  }
}
