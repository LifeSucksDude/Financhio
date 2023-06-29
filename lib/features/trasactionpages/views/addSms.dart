import 'package:financhio/common/widegets/error_page.dart';
import 'package:financhio/common/widegets/forAppOverall/customButton.dart';
import 'package:financhio/common/widegets/loading.dart';
import 'package:financhio/features/trasactionpages/repository/addTransactionRepo.dart';
import 'package:financhio/homeview.dart';
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
      body: Center(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:16.0),
              child: Text('Heyy! We need access to your SMS, to analyse your expenses',style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.w600),),
            ),
            SizedBox(height: 50,),
            CustomButton(backgroundColor: Colors.green, onTap: (){
              
            }, text: 'Allow', textColor: Colors.white),
            SizedBox(height: 20,),
          ]
        ),
      
      ),
      floatingActionButton: GestureDetector(
        onTap: (){
         Navigator.push(context, HomePage.route());
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Deny'),
        )),
      
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