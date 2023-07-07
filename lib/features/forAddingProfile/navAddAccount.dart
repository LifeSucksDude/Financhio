import 'package:financhio/Theme/pallete.dart';
import 'package:financhio/common/utils/utils.dart';
import 'package:financhio/common/widegets/forAppOverall/customButton.dart';
import 'package:financhio/common/widegets/forAppOverall/customTextFieldApp.dart';
import 'package:financhio/common/widegets/forLogin/buttontype.dart';
import 'package:financhio/features/authfeatures/controller/authcontroller.dart';
import 'package:financhio/features/trasactionpages/views/smsStat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    
     double balance = double.tryParse(addBalance.text) ?? 0.0;
    if(BankName.isNotEmpty){
      
      ref.read(authControllerProvider).addBankName(context, BankName, Description, balance);
     
    }
    else{
      showSnackBar(context: context, content: "balance and bankname are required");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.purpleColor,
      appBar: AppBar(
          title: const Text(
            'Add new account',
            style: TextStyle(color: Pallete.whiteColor),
          ),
          leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_new,color: Pallete.whiteColor,)),
          backgroundColor:Pallete.purpleColor),
      body:SingleChildScrollView(
        child: Container(
          height:MediaQuery.of(context).size.height ,
          child: Column(
            children: [
              const SizedBox(
                height: 180,
              ),
              const Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Enter current balance',
                      style: TextStyle(
                          fontSize: 20,
                          color: Pallete.whiteColor,
                          fontWeight: FontWeight.w700),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: TextField(
                  style: TextStyle(fontSize: 50, color:Pallete.whiteColor),
                  controller: addBalance,
                   keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
        ],
                  decoration: InputDecoration(
                    
                    hintText: '0.00',
                    hintStyle: TextStyle(fontSize: 50, color:Pallete.whiteColor),
                    border: InputBorder.none,
                  ),
                  maxLines: 1,
                ),
              ),
            
             Expanded(
               child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color:Pallete.whiteColor,
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
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text('Enter the bank name:',
                                style: TextStyle(
                                    color: Pallete.backgroundColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500)),
                          )),
                          SizedBox(height: 40,),
                     
                      CustomTextFieldApp(
                          hintText: 'Bank name',
                          enabledBorderColor: Pallete.greyColor,
                          backgroundColor: Pallete.whiteColor,
                          controller: bankName,
                          focusedBOrderColor:Pallete.purpleColor),
                          SizedBox(
                        height: 40,
                      ),
                          
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text('Any description for this bank?',
                                style: TextStyle(
                                    color:Pallete.backgroundColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400)),
                          )),
                    SizedBox(height: 20,),
                      CustomTextFieldApp(
                          hintText: 'Enter description',
                          enabledBorderColor: Pallete.greyColor,
                          backgroundColor: Pallete.whiteColor,
                          controller: addDescription!,
                          focusedBOrderColor: Pallete.purpleColor),
                          SizedBox(height: 40,),
                         CustomButton(backgroundColor: Pallete.purpleColor , onTap: (){
                          addBankNameDownit();
                        
                         }, text: 'Add account', textColor:Pallete.whiteColor),
                         SizedBox(height: 50,)
                    ]),
                  ),
             ),
            
            ],
          ),
        ),
      ),
    );
  }
}
