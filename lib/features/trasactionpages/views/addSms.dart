import 'package:financhio/common/widegets/error_page.dart';
import 'package:financhio/common/widegets/loading.dart';
import 'package:financhio/features/trasactionpages/repository/addTransactionRepo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:telephony/telephony.dart';

import '../controller/addtransactionController.dart';

class AddAllSms extends ConsumerWidget {
  
  const AddAllSms({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      body: Center(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Heyy! We need to access your SMS inorder to analyse your expenses',style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.w600),)
          ],
        ),
      ),)
      
       /* ref.watch(smsMessageProviderfor).when(data:(messages)=>ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context,index){
          final address=messages[index].address;
          final body=messages[index].body;
      return ListTile(
        title: Text(address!),
        subtitle: Text(body!),
      );
      }), error:(err,trace)=>ErrorText(error: err.toString()), loading:()=> const Loader()),*/
    );
  }
}