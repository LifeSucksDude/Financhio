import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financhio/common/pages/mainScreen.dart';
import 'package:financhio/common/utils/utils.dart';
import 'package:financhio/features/authfeatures/controller/authcontroller.dart';
import 'package:financhio/features/authfeatures/views/signUpPageView.dart';
import 'package:financhio/features/trasactionpages/controller/addtransactionController.dart';
import 'package:financhio/homeview.dart';
import 'package:financhio/models/bankModel.dart';
import 'package:financhio/models/transaction.dart';
import 'package:financhio/models/userModel.dart';
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

  Future<List<String?>>? selectBankNow(BuildContext context) async {
    List<String> options = await getBanksList();
    return options;
  }

  Stream<BankModel> getBankData(String bankName) {
    String uid = auth.currentUser!.uid;
    print(uid);

    return firestore
        .collection('users')
        .doc(uid)
        .collection('banks')
        .doc(bankName)
        .snapshots()
        .map((event) => BankModel.fromMap(event.data()!));
  }
   Stream<UserModel> getUserData() {
    String uid = auth.currentUser!.uid;
    print(uid);

    return firestore
        .collection('users')
        .doc(uid)
      
      
        .snapshots()
        .map((event) => UserModel.fromMap(event.data()!));
  }

  Stream<List<TransactionModel>> getAllTransactionForPeriod(
      String period, String bankName) {
    print("iamcalled");
    print(period);
    String uid = auth.currentUser!.uid;
    return firestore
        .collection('users')
        .doc(uid)
        .collection('banks')
        .doc(bankName)
        .collection('transaction')
        .snapshots()
        .asyncMap((event) {
      List<TransactionModel> transactions = [];
      for (var document in event.docs) {
        var myTransaction = TransactionModel.fromMap(document.data());
        if (isTransactionWithinPeriod(myTransaction, period)) {
          print("yeet");
          transactions.add(myTransaction);
          print(transactions);
        }
      }
      print(transactions);
      return transactions;
    });
  }

  bool isTransactionWithinPeriod(TransactionModel transaction, String period) {
    DateTime now = DateTime.now();
    DateTime transactionDateTime = DateTime.parse(transaction.datetime);

    switch (period) {
      case "Day":
        DateTime startOfDay = DateTime(now.year, now.month, now.day);
        DateTime endOfDay = startOfDay.add(Duration(days: 1));
        return transactionDateTime.isAfter(startOfDay) &&
            transactionDateTime.isBefore(endOfDay);
      case "Week":
        DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
        DateTime endOfWeek = startOfWeek.add(Duration(days: 7));
        return transactionDateTime.isAfter(startOfWeek) &&
            transactionDateTime.isBefore(endOfWeek);
      case "Month":
        DateTime startOfMonth = DateTime(now.year, now.month, 1);
        DateTime endOfMonth =
            DateTime(startOfMonth.year, startOfMonth.month + 1, 1)
                .subtract(Duration(days: 1));
        return transactionDateTime.isAfter(startOfMonth) &&
            transactionDateTime.isBefore(endOfMonth);
      case "Year":
        DateTime startOfYear = DateTime(now.year, 1, 1);
        DateTime endOfYear =
            DateTime(startOfYear.year + 1, 1, 1).subtract(Duration(days: 1));
        return transactionDateTime.isAfter(startOfYear) &&
            transactionDateTime.isBefore(endOfYear);
      default:
        return false;
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
    required double amount,
    
  }) async {
    try {
      String uid = auth.currentUser!.uid;
      DateTime currentDatetime = DateTime.now();
    String tuid = uid + currentDatetime.toString();
    
      String? photoUrl;
      if (attachment != null) {
        photoUrl = await ref
            .read(commonFirebaseStorageProvider)
            .storeFiletoFirebase('attachment/$uid', attachment);
      }

      var transaction = TransactionModel(
        datetime: datetime,
        description: description,
        type: type,
        amount: amount,
        category: category,
        bankName: bankName,
        attachment: photoUrl,
        tuid: tuid
      );

      // Add transaction to the 'transaction' collection

       var transactionRef = firestore
          .collection('users')
          .doc(uid)
          .collection('banks')
          .doc(bankName)
          .collection('transaction').doc(tuid);
          transactionRef.set(transaction.toMap());
        

      QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection('users')
          .doc(uid)
          .collection('banks')
          .doc(bankName)
          .collection('transaction')
          .get();
      print(snapshot);
      double totIncome = 0;
      double totExpense = 0;

      // Calculate the total income and total expense from the transactions
      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data();
        String transactionType = data['type'];
        double transactionAmount = data['amount'];

        if (transactionType == 'Income') {
          totIncome += transactionAmount;
        } else if (transactionType == 'Expense') {
          totExpense += transactionAmount;
        }
      }

      DocumentSnapshot<Map<String, dynamic>> bankDocSnapshot = await firestore
          .collection('users')
          .doc(uid)
          .collection('banks')
          .doc(bankName)
          .get();
      print(bankDocSnapshot);

      Map<String, dynamic>? bankData = bankDocSnapshot.data();

      if (bankData != null) {
        double currBalance = bankData['currentBalance'];
        double originalBalance = bankData['originalBalance'];
        double updatedCurrBalance = originalBalance + totIncome - totExpense;

        // Update the fields in the bank document
        await firestore
            .collection('users')
            .doc(uid)
            .collection('banks')
            .doc(bankName)
            .update({
          'currentBalance': updatedCurrBalance,
          'totIncome': totIncome.toString(),
          'totExpense': totExpense.toString(),
        });
      }

      showSnackBar(context: context, content: 'Transaction added successfully');
       Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) =>HomePage()),
  (Route<dynamic> route) => false,
);
      
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
        double amount = 0;
        String? description;
        String? dateTime;

        dateTime = messages[j].date.toString();
        if (messages[j].address!.contains(bankList[i]+"UPI")||messages[j].address!.contains(bankList[j]+"INB")||messages[j].address!.contains(bankList[j]+"ATM")) {
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
            amount = double.parse(amountMatch.group(1)?.trim() ?? '0.0');
          }
          RegExp transferToRegex = RegExp(
              r'(?:by a/c linked to mobile \d{10}-(\w+)|transfer to ([A-Za-z0-9\s]+))',
              caseSensitive: false);
          Match? transferToMatch =
              transferToRegex.firstMatch(messages[j].body!);
          if (transferToMatch != null) {
            description = transferToMatch.group(1)?.trim() ?? '';
          }
          DateTime currentDatetime = DateTime.now();
    String tuid = uid + currentDatetime.toString();
          await firestore
              .collection('users')
              .doc(uid)
              .collection('banks')
              .doc(bankName)
              .collection('trasaction')
              .doc(tuid)
              .set(TransactionModel(
                      datetime: dateTime,
                      type: type,
                      amount: amount,
                      category: "",
                      bankName: bankName,
                      tuid: tuid)
                  .toMap());
       QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection('users')
          .doc(uid)
          .collection('banks')
          .doc(bankName)
          .collection('transaction')
          .get();
      print(snapshot);
      double totIncome = 0;
      double totExpense = 0;

      // Calculate the total income and total expense from the transactions
      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data();
        String transactionType = data['type'];
        double transactionAmount = data['amount'];

        if (transactionType == 'Income') {
          totIncome += transactionAmount;
        } else if (transactionType == 'Expense') {
          totExpense += transactionAmount;
        }
      }

      DocumentSnapshot<Map<String, dynamic>> bankDocSnapshot = await firestore
          .collection('users')
          .doc(uid)
          .collection('banks')
          .doc(bankName)
          .get();
      print(bankDocSnapshot);

      Map<String, dynamic>? bankData = bankDocSnapshot.data();

      if (bankData != null) {
        double currBalance = bankData['currentBalance'];
        double originalBalance = bankData['originalBalance'];
        double updatedCurrBalance = originalBalance + totIncome - totExpense;

        // Update the fields in the bank document
        await firestore
            .collection('users')
            .doc(uid)
            .collection('banks')
            .doc(bankName)
            .update({
          'currentBalance': updatedCurrBalance,
          'totIncome': totIncome.toString(),
          'totExpense': totExpense.toString(),
        });
      }
        }
      }
    }
    
  }

  Stream<List<TransactionModel>> getAllTransactionForFiltered(
      String bankName, String filter, String sortFilter) {
    print("iamcalledfilter");

    String uid = auth.currentUser!.uid;
    return firestore
        .collection('users')
        .doc(uid)
        .collection('banks')
        .doc(bankName)
        .collection('transaction')
        .snapshots()
        .asyncMap((event) {
      List<TransactionModel> transactions = [];
      for (var document in event.docs) {
        var myTransaction = TransactionModel.fromMap(document.data());

        if (filter == 'All' ||
            (filter == 'Income' && myTransaction.type == 'Income') ||
            (filter == 'Expense' && myTransaction.type == 'Expense')) {
          transactions.add(myTransaction);
        }
      }

      if (sortFilter == 'Highest') {
        transactions.sort((a, b) => b.amount.compareTo(a.amount));
      } else if (sortFilter == 'Lowest') {
        transactions.sort((a, b) => a.amount.compareTo(b.amount));
      } else if (sortFilter == 'Newest') {
        transactions.sort((a, b) =>
            DateTime.parse(b.datetime).compareTo(DateTime.parse(a.datetime)));
      } else if (sortFilter == 'Oldest') {
        transactions.sort((a, b) =>
            DateTime.parse(a.datetime).compareTo(DateTime.parse(b.datetime)));
      }

      print(transactions);
      return transactions;
    });
  }
  Stream<List<Map<String, dynamic>>> dataForPieChart(String bankName) {
  print("iamcalledfilter");

  String uid = auth.currentUser!.uid;
  return firestore
      .collection('users')
      .doc(uid)
      .collection('banks')
      .doc(bankName)
      .collection('transaction')
      .snapshots()
      .asyncMap((event) {
    List<TransactionModel> transactions = [];
    for (var document in event.docs) {
      var myTransaction = TransactionModel.fromMap(document.data());
      transactions.add(myTransaction);
    }

    Map<String, double> incomeMap = {};
    Map<String, double> expenseMap = {};

    for (var transaction in transactions) {
      String category = transaction.category;
      double amount = transaction.amount;
      String type = transaction.type;

      if (type == 'Income') {
        if (incomeMap.containsKey(category)) {
          incomeMap[category] = incomeMap[category]! + amount;
        } else {
          incomeMap[category] = amount;
        }
      } else if (type == 'Expense') {
        if (expenseMap.containsKey(category)) {
          expenseMap[category] = expenseMap[category]! + amount;
        } else {
          expenseMap[category] = amount;
        }
      }
    }

    List<Map<String, dynamic>> result = [];
    for (var category in incomeMap.keys) {
      result.add({
        'category': category,
        'amount': incomeMap[category],
        'type': 'Income',
      });
    }
    for (var category in expenseMap.keys) {
      result.add({
        'category': category,
        'amount': expenseMap[category],
        'type': 'Expense',
      });
    }

    print(result);
    return result;
  });
}

  void deleteTransaction(String tuid,String bankName) async {
  try {
      String uid = auth.currentUser!.uid;
    var transactionRef =
      
   firestore
        .collection('users')
        .doc(uid)
        .collection('banks')
        .doc(bankName)
        .collection('transaction').doc(tuid);
    var transactionSnapshot = await transactionRef.get();
    
    if (transactionSnapshot.exists) {
      await transactionRef.delete();
     
       QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection('users')
          .doc(uid)
          .collection('banks')
          .doc(bankName)
          .collection('transaction')
          .get();
      print(snapshot);
      double totIncome = 0;
      double totExpense = 0;

      // Calculate the total income and total expense from the transactions
      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data();
        String transactionType = data['type'];
        double transactionAmount = data['amount'];

        if (transactionType == 'Income') {
          totIncome += transactionAmount;
        } else if (transactionType == 'Expense') {
          totExpense += transactionAmount;
        }
      }

      DocumentSnapshot<Map<String, dynamic>> bankDocSnapshot = await firestore
          .collection('users')
          .doc(uid)
          .collection('banks')
          .doc(bankName)
          .get();
      print(bankDocSnapshot);

      Map<String, dynamic>? bankData = bankDocSnapshot.data();

      if (bankData != null) {
        double currBalance = bankData['currentBalance'];
        double originalBalance = bankData['originalBalance'];
        double updatedCurrBalance = originalBalance + totIncome - totExpense;

        // Update the fields in the bank document
        await firestore
            .collection('users')
            .doc(uid)
            .collection('banks')
            .doc(bankName)
            .update({
          'currentBalance': updatedCurrBalance,
          'totIncome': totIncome.toString(),
          'totExpense': totExpense.toString(),
        });
      }
       print('Transaction deleted successfully!');

    } else {
      print('Transaction does not exist!');
    }
  } catch (e) {
    print('Delete error: $e');
  }
}
void logoutUser(String uid,BuildContext context) async {
  try {
    await auth.signOut();   
    showSnackBar(context: context, content: "logged out successfully");
    Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => SignUpPageView()),
  (Route<dynamic> route) => false,
);
    
    print('User with UID $uid logged out successfully!');
  } catch (e) {
    print('Logout error: $e');
  }
}

}
