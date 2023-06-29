import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TransactionModel {
  final String type;
  final String amount;
  final String category;
  final String? description;
  final String? attachment;
  final String bankName;
  final String datetime;
  TransactionModel( {
    required this.datetime,
    required this.type,
    required this.amount,
    required this.category,
     this.description,
     this.attachment,
    required this.bankName,
  });

  

  TransactionModel copyWith({
    String? type,
    String? amount,
    String? category,
    String? description,
    String? attachment,
    String? bankName,
    String? datetime,
  }) {
    return TransactionModel(
      type: type ?? this.type,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      description: description ?? this.description,
      attachment: attachment ?? this.attachment,
      bankName: bankName ?? this.bankName,
      datetime: datetime?? this.datetime
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'amount': amount,
      'category': category,
      'description': description,
      'attachment': attachment,
      'bankName': bankName,
      'datetime':datetime
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      type: map['type'] ?? '',
      amount: map['amount'] ?? '',
      category: map['category'] ?? '',
      description: map['description'] != null ? map['description'] ?? '' : null,
      attachment: map['attachment'] != null ? map['attachment'] ?? '' : null,
      bankName: map['bankName'] ?? '',
      datetime: map['datetime'] ?? ''
    );
  }

 
}
