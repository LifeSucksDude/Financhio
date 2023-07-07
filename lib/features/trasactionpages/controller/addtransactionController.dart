import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financhio/features/authfeatures/repositoris/auth_repo.dart';
import 'package:financhio/features/trasactionpages/repository/addTransactionRepo.dart';
import 'package:financhio/models/bankModel.dart';
import 'package:financhio/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addTransactionProvider = Provider((ref) {
  final addTrasactionRepo = ref.watch(addTransactionRepoProvider);
  return AddTransactionController(
      addTransactionRepo: addTrasactionRepo, ref: ref);
});

class AddTransactionController {
  final AddTransaction addTransactionRepo;
  final ProviderRef ref;

  AddTransactionController(
      {required this.addTransactionRepo, required this.ref});

  void ReadAllSms() {
    addTransactionRepo.getAllSms();
  }

  Future<List<String>> addBankList() async {
    return await addTransactionRepo.getBanksList();
  }

  Future<List<String?>>? selectBankForGod(BuildContext context) {
    return addTransactionRepo.selectBankNow(context);
  }

  Stream<BankModel> gettheBankDataPlease(String bankName) {
    return addTransactionRepo.getBankData(bankName);
  }

  void addTransaction(
      String type,
      File? attachment,
      BuildContext context,
      String category,
      String bankName,
      String datetime,
      String description,
      double amount) {
    addTransactionRepo.doTheTransaction(
        type: type,
        attachment: attachment,
        ref: ref,
        context: context,
        category: category,
        bankName: bankName,
        datetime: datetime,
        description: description,
        amount: amount);
  }
  Stream<List<TransactionModel>>QueryListGen(String period,String bankName){
   return addTransactionRepo.getAllTransactionForPeriod(period, bankName);
  }
  Stream<List<TransactionModel>>filterOutList(String bankName,String filter,String sort){
    return addTransactionRepo.getAllTransactionForFiltered(bankName, filter, sort);
  }
  void deleteTransactionBank(String tuid,String bankName){
    ref.watch(addTransactionRepoProvider).deleteTransaction(tuid,bankName);
  }
  void logoutUserforGod(String uid,BuildContext context){
    ref.watch(addTransactionRepoProvider).logoutUser(uid, context);
  }
}
