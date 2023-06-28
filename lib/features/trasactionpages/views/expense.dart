import 'package:flutter/material.dart';

import '../../../common/widegets/forAppOverall/customButton.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final TextEditingController addBalance=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.red,
       appBar:AppBar(
        title: const Text("Expense",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w600),),
        leading: Icon(Icons.arrow_back_ios_new,color: Colors.white,),
        backgroundColor: Colors.red,
       ) ,
       body: Column(
        children: [
          const SizedBox(
            height: 150,
          ),
          const Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Enter current balance',
                  style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(251, 197, 194, 252),
                      fontWeight: FontWeight.w700),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: TextField(
              style: TextStyle(fontSize: 50, color: Colors.white),
              controller: addBalance,
              decoration: InputDecoration(
                
                hintText: '0.00',
                hintStyle: TextStyle(fontSize: 50, color: Colors.white),
                border: InputBorder.none,
              ),
              maxLines: 1,
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(children: [
                SizedBox(
                  height: 40,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: DropdownButton(items: [DropdownMenuItem(child: Container(
                        width: 200,
                      
                        
                        child: Row(
                        children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage('assets/images/food.png'))
                        ),
                      ),
                      SizedBox(width: 10,),
                        Text('Food',style: TextStyle(fontSize: 32),),
                        ],
                        
                        ),
                      ))],
                      onChanged: (value) {
                        
                      },
                      )
                    )),
               
              
                    SizedBox(height: 32,),
                   CustomButton(backgroundColor: const Color.fromRGBO(98, 63, 255, 1) , onTap: (){}, text: 'Add account', textColor: Colors.white)
              ]),
            ),
          ),
        ],
      ),
    );
  }
}