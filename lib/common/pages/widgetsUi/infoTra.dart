// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financhio/common/utils/utils.dart';
import 'package:financhio/features/authfeatures/controller/authcontroller.dart';
import 'package:financhio/features/trasactionpages/controller/addtransactionController.dart';
import 'package:flutter/material.dart';

import 'package:financhio/Theme/pallete.dart';
import 'package:financhio/models/transaction.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';


class TransactionInfo extends ConsumerWidget {
 final TransactionModel transaction;
 TransactionInfo({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    DateTime dateTime = DateTime.parse(transaction.datetime);

String formattedDate = DateFormat('EEEE, dd/MM/yyyy').format(dateTime);
String formattedTime = DateFormat('hh:mm a').format(dateTime);
    return Scaffold(
      body: 
      SingleChildScrollView(
        child: Container(
          //      height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
            color: Pallete.whiteColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Container(
                height:MediaQuery.of(context).size.height/2.5,
                decoration: BoxDecoration(
                  color: transaction.type=='Expense'?Pallete.redColor:Pallete.greenColor,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40))
                  
                ),
                child: Stack(
                  children: [
                  
                    Padding(
                      padding: const EdgeInsets.only(left:20.0,right: 20.0,top: 70),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon( Icons.arrow_back_ios_new,color: Pallete.whiteColor,)),
                          Text("Transaction Detail",style: TextStyle(fontSize: 18,color: Pallete.whiteColor,fontWeight: FontWeight.w700)),
                          GestureDetector(
                            onTap: (){
                            ref.watch(addTransactionProvider).deleteTransactionBank(transaction.tuid,transaction.bankName);
                            Navigator.pop(context);
                         //   showSnackBar(context: context, content: "Deleted");
                            },
                            child: Icon(Icons.delete,color:Colors.white,size: 28,))
                      ],),
                      
        
                    ),
                    Center(child: Text("Rs."+transaction.amount.toString(),style: TextStyle(fontSize: 48,color:Pallete.whiteColor,fontWeight: FontWeight.w500),)),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top:150.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(formattedDate,style: TextStyle(color: Pallete.whiteColor,fontSize: 13,fontWeight: FontWeight.w900),),
                            SizedBox(width: 4,),
                            Text(formattedTime,style: TextStyle(fontSize: 13,color: Pallete.whiteColor,fontWeight: FontWeight.w900),)
                          ],
                        ),
                        
                      )),
                      Padding(
                        padding: const EdgeInsets.only(left:20.0,right: 20.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: Pallete.whiteColor,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
                              
                            
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical:5.0,horizontal: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("Type",style: TextStyle(fontSize: 14,color: Pallete.greyColor),),
                                   
                                        Text("Category",style: TextStyle(fontSize: 14,color: Pallete.greyColor),),
                                          Text("Bank",style: TextStyle(fontSize: 14,color: Pallete.greyColor),)
                                
                                    ],
                                  ),
                                  
                                ),
                             
                                 Padding(
                                   padding: const EdgeInsets.symmetric(horizontal:5.0,),
                                   child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                     
                                      children: [
                                        Text(transaction.type,style: TextStyle(fontSize: 14,color: Pallete.backgroundColor,fontWeight: FontWeight.w700),),
                                          Center(child: Text(transaction.category,style: TextStyle(fontSize: 14,color: Pallete.backgroundColor,fontWeight: FontWeight.w700),)),
                                          SizedBox(height: 0,),
                                            Text(transaction.bankName,style: TextStyle(fontSize: 14,color: Pallete.backgroundColor,fontWeight: FontWeight.w700),)
                                                             
                                      ],
                                    ),
                                 ),
            
        
                              ],
                            ),
                          ),
                        ),
                      )
                    
                   
        
                ]),
               ),
               SizedBox(height: 5,),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal:20.0),
                 child: Divider(
                        
                  thickness: 0.5,
                  color: Pallete.greyColor,
        
                  
                 ),
                 
        
               ),
               SizedBox(height: 10,),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
                 child: Text("Description",style: TextStyle(fontSize: 16,color: Pallete.greyColor,fontWeight: FontWeight.w500),),
              
               ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:20.0),
                  
                    
                      
                      child: Container(
                     //   height: 60,
                        child: Text(transaction.description==null?"No Description":"${transaction.description!}",style: TextStyle(fontSize: 16,color: Pallete.backgroundColor,fontWeight: FontWeight.w600,),)),
                    ),
                
                  SizedBox(height: 20,),
                  if(transaction.attachment!=null) Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: MediaQuery.of(context).size.width-40,
                      decoration: BoxDecoration(
                        color: Pallete.backgroundColor,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        
                        image: DecorationImage(image: NetworkImage(transaction.attachment!),fit: BoxFit.contain)
                      ),
        
                    ),
        
                  ),
                  if(transaction.attachment==null) Container(child: Center(child: Text("No Attachement")),)
                 
              ],
            ),
          ),
      ),
      )
      
    ;
  }
}
