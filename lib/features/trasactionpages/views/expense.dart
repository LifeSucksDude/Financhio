import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financhio/common/utils/utils.dart';
import 'package:financhio/common/widegets/dropdownpage.dart';
import 'package:financhio/common/widegets/forAppOverall/customTextFieldApp.dart';
import 'package:financhio/features/authfeatures/controller/authcontroller.dart';
import 'package:financhio/features/forAddingProfile/addAccount.dart';
import 'package:financhio/features/trasactionpages/controller/addtransactionController.dart';
import 'package:financhio/features/trasactionpages/repository/addTransactionRepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/widegets/forAppOverall/customButton.dart';

class AddExpense extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const AddExpense());
  const AddExpense({super.key});

  @override
  ConsumerState<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends ConsumerState<AddExpense> {
  String? selectedBank;
  String? selectedCategory;
  File? image;

  List<String> bankList = [];

  final TextEditingController addExpense = TextEditingController();
  final TextEditingController addDescription = TextEditingController();
  String? selectedValue;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      getBankNameList();
    });
    super.initState();
  }

  void getBankNameList() async {
    bankList = await ref.watch(addTransactionProvider).addBankList();

    setState(() {});
    print(bankList);
  }

  void storeTheTransaction() {
    
    double amount = double.tryParse(addExpense.text) ?? 0.0;
    String type = 'Expense';
    String? bankName = selectedBank;
    String category = '$selectedCategory';
    String description = addDescription.text;
    File? attachment = image;
    DateTime dateTime = DateTime.now();
    String datetimeString = dateTime.toString();
    if (amount!=0.0 && bankName!=null) {
      ref.read(addTransactionProvider).addTransaction(type, attachment, context,
          category, bankName, datetimeString, description, amount);
    } else {
      showSnackBar(
          context: context, content: "0.0 amount,Empty bankName not allowed ");
    }
  }

  void selelctImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: const Text(
          "Expense",
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                      'How much?',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(249, 255, 235, 235),
                          fontWeight: FontWeight.w700),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: TextField(
                  style: TextStyle(fontSize: 50, color: Colors.white),
                  controller: addExpense,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  decoration: InputDecoration(
                    hintText: '0.00',
                    hintStyle: TextStyle(fontSize: 50, color: Colors.white),
                    border: InputBorder.none,
                  ),
                  maxLines: 1,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(children: [
                    const SizedBox(
                      height: 60,
                    ),
                    MyDropdownWidget(
                        onItemSelected: (value) {
                          selectedCategory = value;
                        },
                        hintText: 'Category',
                        dropdownItems: [
                          'Food',
                          'Technology',
                          'Fees',
                          'Shopping',
                          'Others'
                        ],
                        textColor: const Color.fromARGB(255, 73, 73, 73)),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextFieldApp(
                        hintText: 'Description',
                        enabledBorderColor: Color.fromARGB(255, 208, 208, 208),
                        backgroundColor: Colors.white,
                        controller: addDescription,
                        focusedBOrderColor:
                            const Color.fromARGB(255, 203, 168, 166)),
                    SizedBox(
                      height: 20,
                    ),
                    MyDropdownWidget(
                      onItemSelected: (value) {
                        selectedBank = value;
                      },
                      dropdownItems: bankList,
                      textColor: const Color.fromARGB(255, 73, 73, 73),
                      hintText: 'Select Bank',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        selelctImage();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          height: 56,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Color.fromARGB(255, 227, 227, 227),
                              )),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.attach_file),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Add attachment')
                            ],
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CustomButton(
                        backgroundColor: const Color.fromRGBO(98, 63, 255, 1),
                        onTap: () {
                          storeTheTransaction();
                        },
                        text: 'Add Expense',
                        textColor: Colors.white),
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
