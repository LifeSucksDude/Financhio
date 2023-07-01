import 'package:financhio/common/widegets/forLogin/buttontype.dart';
import 'package:flutter/material.dart';

import 'navAddAccount.dart';

class AddListofBankName extends StatelessWidget {
    static route()=> MaterialPageRoute(builder: (context)=>const AddListofBankName());
  const AddListofBankName({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
           SizedBox(height: 20,),
            Text(
              "Let's setup your account!",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 45,
                  fontWeight: FontWeight.w500),
            ),
           
            Text(
                "Account is your bank name, please add a correct name it's important to enter a valid bank name",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w500)),
                    SizedBox(height: 20,),
                    SizedBox(height: 20,),
                    
          GestureDetector(
            onTap: (){
              Navigator.push(context, AddAccountPage.route());
            },
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color:  Color.fromRGBO(98, 63, 255, 1),
              borderRadius: BorderRadius.circular(16)),
              child: 
              Center(
                child: Text("Let's go",style: TextStyle(color: Colors.white,fontSize: 16)
                ),
              ),
              
            ),
          ),
        
          ],
        ),
      ),
    );
  }
}
