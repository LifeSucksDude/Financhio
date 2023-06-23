import 'package:flutter/material.dart';

class AddAccountPage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AddAccountPage());
  const AddAccountPage({super.key});

  @override
  State<AddAccountPage> createState() => _AddAccountPageState();
}

class _AddAccountPageState extends State<AddAccountPage> {
 final TextEditingController balanceController=TextEditingController();
 final TextEditingController addBalance=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(98, 63, 255, 1),
      appBar: AppBar(
          title: const Text(
            'Add new account',
            style: TextStyle(color: Colors.white),
          ),
          leading: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          backgroundColor: const Color.fromRGBO(98, 63, 255, 1)),
      body: Column(
        children: [
        const SizedBox(
            height: 150,
          ),
       const   Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, ),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Enter current balnce',
                  style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(251, 197, 194, 252),
                      fontWeight: FontWeight.w700),
                )),
          ),
         
          
           
          
             
            Padding(
              padding: const EdgeInsets.only(left:16.0),
              child: TextField(
                  style: TextStyle(
                    
                    fontSize: 50,
                    color: Colors.white
                  ),
                  controller: addBalance ,
                  decoration: InputDecoration(
                    prefix: 
              
               Text('Rs.',style: TextStyle(fontSize: 50,color: Colors.white),
                
                
                
              ),
                    hintText: '0.00',
                    hintStyle: TextStyle(fontSize: 50,color: Colors.white),
                    border: InputBorder.none,
                  
                    
                    
                  ),
                  maxLines: 1,
              
                ),
            ),
           
           
          
          Expanded(
            child: Container(
              decoration:const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
            ),
          )
        ],
      ),
    );
  }
}
