import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TransactionModel {
  final String type;
  final String tuid;
  final double amount;
  final String category;
  final String? description;
  final String? attachment;
  final String bankName;
  final String datetime;
  TransactionModel( {
    required this.tuid,
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
    double? amount,
    String? category,
    String? description,
    String? attachment,
    String? bankName,
    String? datetime,
    String? tuid,
  }) {
    return TransactionModel(
      tuid: tuid?? this.tuid,
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
      'datetime':datetime,
      'tuid':tuid
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      type: map['type'] ?? '',
      amount: map['amount'] ?? 0,
      category: map['category'] ?? 'Non',
      description: map['description'] != null ? map['description'] ?? '' : null,
      attachment: map['attachment'] != null ? map['attachment'] ?? '' : null,
      bankName: map['bankName'] ?? '',
      datetime: map['datetime'] ?? '',
      tuid:  map['tuid'],
    );
  }

 
}
