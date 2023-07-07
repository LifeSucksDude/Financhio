import 'package:financhio/common/pages/trasactionscreen.dart';
import 'package:financhio/common/widegets/loading.dart';
import 'package:financhio/features/trasactionpages/controller/addtransactionController.dart';
import 'package:financhio/homeview.dart';
import 'package:financhio/models/bankModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Theme/pallete.dart';
import 'widgetsUi/mylist.dart';
import 'widgetsUi/plotScroll.dart';
import 'widgetsUi/slectable.dart';
final mySelectedBankProvider=StateProvider<Future<String?>>((ref) async{
   SharedPreferences _preferences = await SharedPreferences.getInstance();
  print(_preferences.getString('selectedBank'));
  return _preferences.getString('selectedBank');
});

final selecteValueProvider=StateProvider((ref) {
  return
  "Day";
},);
class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  ScrollController scrollController = ScrollController();
 
 
  bool closeTopContainer = false;

  



  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double graphHeight = size.height * 0.20;
    return 
       FutureBuilder(
        future: ref.watch(mySelectedBankProvider),
         builder: (context,snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return Loader();
          }
       
       
         
          if(selectedBank==null && snapshot.data==null){
            return Center(child: Text("Please Select a Bank",style: TextStyle(fontSize: 32,color: Colors.black),));
          }
          String bankName=snapshot.data!;
        
           return Consumer(
            builder: (context, ref, child) {
           //  final bankName= ref.watch(mySelectedBankProvider);
            // print(bankName);
             return
               Scaffold(
              body: Container(
               // height:MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 255, 252, 239),
                      Color.fromARGB(255, 255, 255, 255)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    StreamBuilder(
                      stream: ref.watch(addTransactionProvider).addTransactionRepo.getBankData(bankName!) ,
                      builder: (context,snapshot) {
                        if(snapshot.connectionState==ConnectionState.waiting){
                          return const Loader();
                        }
                        return Column(
                          children: [
                            Center(
                                child: Text(
                              "Account Balance",
                              style: TextStyle(color: Colors.black54, fontSize: 14),
                            )),
                             SizedBox(
                          height: 2,
                        ),
                        //add Balance
                        Text(
                          "Rs."+"${snapshot.data!.currentBalance.toInt()}",
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
           
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 80,
                                //   width: 164,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32),
                                    color: Pallete.greenColor),
                                child: Center(
                                  child: Row(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Container(
                                        height: 48,
                                        width: 48,
                                        decoration: BoxDecoration(
                                          color: Pallete.whiteColor,
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        child: Icon(
                                          Icons.monetization_on,
                                          color: Pallete.greenColor,
                                          size: 32,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Income",
                                          style: TextStyle(
                                              color: Pallete.whiteColor, fontSize: 14),
                                        ),
                                        // SizedBox(height: 8,),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 8.0),
                                          child: Text(
                                            "Rs."+"${double.parse(snapshot.data!.totIncome).toStringAsFixed(0)}",
                                            style: TextStyle(
                                                color: Pallete.whiteColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w900,
                                                overflow: TextOverflow.ellipsis),
                                          ),
                                        )
                                      ],
                                    )
                                  ]),
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Container(
                                height: 80,
                                //  width: 164,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32),
                                    color: Pallete.redColor),
                                child: Center(
                                  child: Row(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Container(
                                        height: 48,
                                        width: 48,
                                        decoration: BoxDecoration(
                                          color: Pallete.whiteColor,
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        child: Icon(
                                          Icons.money_off,
                                          color: Pallete.redColor,
                                          size: 32,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Expense",
                                          style: TextStyle(
                                              color: Pallete.whiteColor, fontSize: 14),
                                        ),
                                        // SizedBox(height: 8,),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 8.0),
                                          child: Text(
                                            "Rs."+"${double.parse(snapshot.data!.totExpense).toStringAsFixed(0)}",
                                            style: TextStyle(
                                                color: Pallete.whiteColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w900,
                                                overflow: TextOverflow.ellipsis),
                                          ),
                                        )
                                      ],
                                    )
                                  ]),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                          ],
                        );
                      }
                    ),
                   
                    const Divider(
                      color: Colors.grey, // Customize the color of the divider
                      height: 1, // Adjust the height of the divider
                      thickness: 1, // Adjust the thickness of the divider
                      indent: 20, // Adjust the left indentation of the divider
                      endIndent: 20, // Adjust the right indentation of the divider
                    ),
           
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Spending Analytics",
                            style: TextStyle(
                                fontSize: 18,
                                color: Pallete.backgroundColor,
                                fontWeight: FontWeight.w600),
                          )),
                    ),
                    const Divider(
                      color: Colors.grey, // Customize the color of the divider
                      height: 1, // Adjust the height of the divider
                      thickness: 1, // Adjust the thickness of the divider
                      indent: 20, // Adjust the left indentation of the divider
                      endIndent: 20, // Adjust the right indentation of the divider
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                      final  selectedValue=ref.watch(selecteValueProvider);
                      
                      return Container(
                        height: 452,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SelectableItem(
                                  label: 'Day',
                                  isSelected: selectedValue == 'Day',
                                  onTap: () {
                                    ref.read(selecteValueProvider.notifier).update((state) => 'Day');
                                  },
                                ),
                                SelectableItem(
                                  label: 'Week',
                                  isSelected: selectedValue == 'Week',
                                  onTap: () {
                                    ref.read(selecteValueProvider.notifier).update((state) => 'Week');
                                  },
                                ),
                                SelectableItem(
                                  label: 'Month',
                                  isSelected: selectedValue == 'Month',
                                  onTap: () {
                                     ref.read(selecteValueProvider.notifier).update((state) => 'Month');
                                  },
                                ),
                                SelectableItem(
                                  label: 'Year',
                                  isSelected: selectedValue == 'Year',
                                  onTap: () {
                                     ref.read(selecteValueProvider.notifier).update((state) => 'Year');
                                  },
                                ),
                                    
                                //Make The Plot Here, Make this a list
                              ],
                            ),
                             SizedBox(
                        height: 6,
                                    ),
                      
                                    AnimatedOpacity(
                        duration: const Duration(milliseconds: 400),
                        opacity: closeTopContainer ? 0 : 1,
                        child: AnimatedContainer(
                            alignment: Alignment.topCenter,
                            height: closeTopContainer ? 0 : graphHeight,
                            duration: const Duration(milliseconds: 400),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: PlotScroller(period: selectedValue,bankName: bankName!,),
                            )),
                                    ),
                      
                                    const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Text(
                              "Recent Transaction",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Pallete.purpleColor),
                            ),
                          )),
                                    Expanded(
                          child: TransactionListView(
                              selectedValue, bankName, scrollController))
                          ],
                        ),
                      );}
                        
                    ),
                   
                  ],
                ),
              ),
                 );
              
           
            }
           );
         }
       )
       ;
  }
       
    
  }

