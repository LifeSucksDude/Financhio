import 'package:financhio/features/trasactionpages/repository/addTransactionRepo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final smsMessageProviderfor=FutureProvider((ref) {
  final addTrasactionRepo=ref.watch(smsMessageProvider);
  return addTrasactionRepo.getAllSms();
});