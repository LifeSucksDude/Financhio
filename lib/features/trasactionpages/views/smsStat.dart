import 'package:financhio/features/authfeatures/repositoris/auth_repo.dart';
import 'package:financhio/features/trasactionpages/controller/addtransactionController.dart';
import 'package:financhio/features/trasactionpages/repository/addTransactionRepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/widegets/forAppOverall/customButton.dart';
import '../../../homeview.dart';

class AddStateMessage extends ConsumerStatefulWidget {
   static route()=> MaterialPageRoute(builder: (context)=>const AddStateMessage());
  const AddStateMessage({super.key});

  @override
 ConsumerState<AddStateMessage> createState() => _AddStateMessageState();
}

class _AddStateMessageState extends ConsumerState<AddStateMessage> {
  @override
 
  Widget build(BuildContext context) {
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
              ref.watch(addTransactionProvider).addTransactionRepo.addAllSmsAndStoreThem();
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
     
      /*  ref.watch(smsMessageProviderfor).when(data:(messages)=>ListView.builder(
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