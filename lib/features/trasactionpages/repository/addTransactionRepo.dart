import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:telephony/telephony.dart';

final smsMessageProvider = Provider(
  (ref) => AddTransaction(
    firestore: FirebaseFirestore.instance,
  ),
);

class AddTransaction {
  final FirebaseFirestore firestore;
  final Telephony telephony = Telephony.instance;

  AddTransaction({required this.firestore});
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
 
}
