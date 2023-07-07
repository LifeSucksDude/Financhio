// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BankModel {
  final double currentBalance;
  final String description;
  final String totExpense;
  final String totIncome;
  final double originalBalance;
  BankModel({
    required this.currentBalance,
    required this.description,
    required this.totExpense,
    required this.totIncome,
    required this.originalBalance
  });

  BankModel copyWith({
    double? currentBalance,
    String? description,
    String? totExpense,
    String? totIncome,
    double? originalBalance,
  }) {
    return BankModel(
      currentBalance: currentBalance ?? this.currentBalance,
      description: description ?? this.description,
      totExpense: totExpense ?? this.totExpense,
      totIncome: totIncome ?? this.totIncome,
      originalBalance: originalBalance?? this.originalBalance
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentBalance': currentBalance,
      'description': description,
      'totExpense': totExpense,
      'totIncome': totIncome,
      'orinalBalance':originalBalance
    };
  }

  factory BankModel.fromMap(Map<String, dynamic> map) {
    return BankModel(
      currentBalance: map['currentBalance'] ?? 0.0,
      description: map['description'] ?? '',
      totExpense: map['totExpense'] ?? '',
      totIncome: map['totIncome'] ?? '',
      originalBalance: map['originalBalance']?? 0.0
    );
  }

}