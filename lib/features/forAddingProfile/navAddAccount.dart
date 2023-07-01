import 'package:financhio/common/utils/utils.dart';
import 'package:financhio/common/widegets/forAppOverall/customButton.dart';
import 'package:financhio/common/widegets/forAppOverall/customTextFieldApp.dart';
import 'package:financhio/common/widegets/forLogin/buttontype.dart';
import 'package:financhio/features/authfeatures/controller/authcontroller.dart';
import 'package:financhio/features/trasactionpages/views/smsStat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddAccountPage extends ConsumerStatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AddAccountPage());
  const AddAccountPage({super.key});

  @override
  ConsumerState<AddAccountPage> createState() => _AddAccountPageState();
}

class _AddAccountPageState extends ConsumerState<AddAccountPage> {
  final bankName = TextEditingController();

  final TextEditingController addBalance = TextEditingController();
  final TextEditingController? addDescription=TextEditingController();
  @override
  void dispose() {
   
    super.dispose();
    addBalance.dispose();
    bankName.dispose();
    addDescription!.dispose();
  }
  void addBankNameDownit(){
    String BankName=bankName.text;
    String Description=addDescription!.text;
    String balance=addBalance.text;
    if(BankName.isNotEmpty && balance.isNotEmpty){
      ref.read(authControllerProvider).addBankName(context, BankName, Description, balance);
     
    }
    else{
      showSnackBar(context: context, content: "balance and bankname are required");
    }
  }
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 140,
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
          
           Container(
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
                        child: Text('Enter the bank name:',
                            style: TextStyle(
                                color: Color.fromARGB(255, 32, 30, 30),
                                fontSize: 20,
                                fontWeight: FontWeight.w400)),
                      )),
                      SizedBox(height: 30,),
                 
                  CustomTextFieldApp(
                      hintText: 'Bank name',
                      enabledBorderColor: Color.fromARGB(255, 102, 102, 102),
                      backgroundColor: Colors.white,
                      controller: bankName,
                      focusedBOrderColor: const Color.fromRGBO(98, 63, 255, 1)),
                      SizedBox(
                    height: 20,
                  ),
                      
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text('Any description for this bank?',
                            style: TextStyle(
                                color: Color.fromARGB(255, 32, 30, 30),
                                fontSize: 20,
                                fontWeight: FontWeight.w300)),
                      )),
                SizedBox(height: 30,),
                  CustomTextFieldApp(
                      hintText: 'Enter description',
                      enabledBorderColor: Color.fromARGB(255, 102, 102, 102),
                      backgroundColor: Colors.white,
                      controller: addDescription!,
                      focusedBOrderColor: const Color.fromRGBO(98, 63, 255, 1)),
                      SizedBox(height: 30,),
                     CustomButton(backgroundColor: const Color.fromRGBO(98, 63, 255, 1) , onTap: (){
                      addBankNameDownit();
                      Navigator.push(context, AddStateMessage.route());
                     }, text: 'Add account', textColor: Colors.white),
                     SizedBox(height: 50,)
                ]),
              ),
          
          ],
        ),
      ),
    );
  }
}
