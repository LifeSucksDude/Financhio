import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financhio/common/utils/utils.dart';
import 'package:financhio/features/trasactionpages/controller/addtransactionController.dart';
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

  Future<List<String>> getBanksList() async {
    String uid = auth.currentUser!.uid;
    print(uid);
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection('users')
          .doc(uid)
          .collection('banks')
          .get();
      print(snapshot);

      List<String> bankList = snapshot.docs.map((doc) => doc.id).toList();
      return bankList;
    } catch (e) {
      print('Error retrieving banks: $e');
      return [];
    }
  }

  void doTheTransaction(
      {required String type,
      required File? attachment,
      required ProviderRef ref,
      required BuildContext context,
      required String category,
      required String bankName,
      required String datetime,
      required String description,
      required String amount}) async {
    try {
      String uid = auth.currentUser!
          .uid; //i can't be null because of the navigation of the app pages
      String? photoUrl;
      if (attachment != null) {
        photoUrl = await ref
            .read(commonFirebaseStorageProvider)
            .storeFiletoFirebase('attachment/$uid', attachment);
      }
      var transaction = TransactionModel(
          datetime: datetime,
          type: type,
          amount: amount,
          category: category,
          bankName: bankName,
          attachment: photoUrl);
      await firestore
          .collection('users')
          .doc(uid)
          .collection('banks')
          .doc(bankName)
          .collection('trasaction')
          .doc()
          .set(transaction.toMap());
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void addAllSmsAndStoreThem() async {
    String uid = auth.currentUser!.uid;

    List<SmsMessage> messages = [];
    List<String> bankList = [];

    messages = await getAllSms();
    bankList = await getBanksList();
    // print(messages);
    print(bankList);
    for (int i = 0; i < bankList.length; i++) {
      for (int j = 0; j < messages.length; j++) {
        String? bankName;
        String type = "";
        String amount = "";
        String? description;
        String? dateTime;

        dateTime = messages[j].date.toString();
        if (messages[j].address!.contains(bankList[i])) {
          bankName = bankList[i];
          if (messages[j].body!.contains('debited')) {
            type = "Expense";
          } else if (messages[j].body!.contains('debit')) {
            type = "Expense";
          } else if (messages[j].body!.contains('credited')) {
            type = "Income";
          } else if (messages[j].body!.contains('credit')) {
            type = "Income";
          }
          RegExp amountRegex =
              RegExp(r'(?:Rs|INR)([\d.]+)', caseSensitive: false);
          Match? amountMatch = amountRegex.firstMatch(messages[j].body!);
          if (amountMatch != null) {
            amount = amountMatch.group(1)?.trim() ?? '';
          }
          RegExp transferToRegex = RegExp(
              r'(?:by a/c linked to mobile \d{10}-(\w+)|transfer to ([A-Za-z0-9\s]+))',
              caseSensitive: false);
          Match? transferToMatch =
              transferToRegex.firstMatch(messages[j].body!);
          if (transferToMatch != null) {
            description = transferToMatch.group(1)?.trim() ?? '';
          }
          await firestore
              .collection('users')
              .doc(uid)
              .collection('banks')
              .doc(bankName)
              .collection('trasaction')
              .doc()
              .set(TransactionModel(
                      datetime: dateTime,
                      type: type,
                      amount: amount,
                      category: "",
                      bankName: bankName)
                  .toMap());
        }
      }
    }
  }
}
