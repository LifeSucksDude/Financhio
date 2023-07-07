import 'package:financhio/Theme/pallete.dart';
import 'package:financhio/features/trasactionpages/views/expense.dart';
import 'package:financhio/features/trasactionpages/views/income.dart';
import 'package:flutter/material.dart';

class AddVarTransaction extends StatefulWidget {
  const AddVarTransaction({super.key});

  @override
  State<AddVarTransaction> createState() => _AddVarTransactionState();
}

class _AddVarTransactionState extends State<AddVarTransaction> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Pallete.whiteColor,


        ),
        child: Column(
          children: [
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              
              child: Container(
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Pallete.whiteFadeColor
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("Select the type of transation:",style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600
                  ),),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, AddIncome.route());
                    },
                    child: Container(
                                   height: 150,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 184, 184, 184),
                          offset: Offset(1, 1),
                          blurRadius: 5,
                          spreadRadius: 5
                         
                        )
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Pallete.greenColor
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: Text("Income",style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w600
                        ),),
                      ),
                    ),
                                  ),
                  ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, AddExpense.route());
                      },
                      child: Container(
                                     height: 150,
                                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Pallete.redColor,
                      boxShadow: [ BoxShadow(
                          color: Color.fromARGB(255, 184, 184, 184),
                          offset: Offset(1, 1),
                          blurRadius: 5,
                          spreadRadius: 5
                         
                        )]
                      
                                      ),
                                      child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: Text("Expense",style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w600
                        ),),
                      ),
                                      ),
                                    ),
                    ),
               
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 244, 244, 244),
                    borderRadius: BorderRadius.circular(20),

                  ),
                  child: Center(child: Text("Add Full Banner Ads")),
                  
                ),
              ),
            )
          ],
        ),
      ),
      
    ));
  }
}