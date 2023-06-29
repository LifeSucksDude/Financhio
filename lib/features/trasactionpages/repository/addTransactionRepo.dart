import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financhio/common/utils/utils.dart';
import 'package:financhio/models/transaction.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:telephony/telephony.dart';
import '../../../common/reposititories/common_firebase_storage_repository.dart';

final addTransactionRepoProvider = Provider(
  (ref) => AddTransaction(
      firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance),
);

class AddTransaction {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final Telephony telephony = Telephony.instance;

  AddTransaction({required this.auth, required this.firestore});
  Future<List<SmsMessage>> getAllSms() async {
    List<SmsMessage> messages = [];
    bool? permissionsGranted = await telephony.requestPhoneAndSmsPermissions;
    try {
      if (permissionsGranted!) {
        messages = await telephony.getInboxSms();
      }
      print(messages);
    } catch (e) {
      debugPrint(e.toString());
    }
    return messages;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? snapShots(BuildContext context) {
    try {
      String uid = auth.currentUser!.uid;
      CollectionReference usersCollection = firestore.collection('users');
      return usersCollection.doc(uid).collection('banks').snapshots();
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
   void doTheTransaction({
    required String type,
    required File? attachment,
    required ProviderRef ref,
    required BuildContext context,
    required String category,
    required String bankName,
    required String datetime,
    required String description,
    required String amount
  }) async {
    try {
      String uid = auth.currentUser!
          .uid; //i can't be null because of the navigation of the app pages
      String? photoUrl;
      if (attachment != null) {
        photoUrl = await ref
            .read(commonFirebaseStorageProvider)
            .storeFiletoFirebase('attachment/$uid', attachment);
      }
      var transaction=TransactionModel(datetime: datetime, type: type, amount: amount, category: category, bankName: bankName,attachment: photoUrl);
      await firestore.collection('users').doc(uid).collection('banks').doc(bankName).collection('trasaction').doc().set(transaction.toMap());
     
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
