

import 'package:financhio/Theme/pallete.dart';
import 'package:financhio/common/pages/addvartrasaction.dart';
import 'package:financhio/common/pages/finRep.dart';

import 'package:financhio/common/pages/profilepage.dart';
import 'package:financhio/common/pages/trasactionscreen.dart';
import 'package:financhio/common/pages/widgetsUi/appBar.dart';
import 'package:financhio/common/pages/widgetsUi/pieChart.dart/piecharts.dart';
import 'package:financhio/features/authfeatures/controller/authcontroller.dart';
import 'package:financhio/features/authfeatures/repositoris/auth_repo.dart';
import 'package:financhio/features/trasactionpages/controller/addtransactionController.dart';
import 'package:financhio/features/trasactionpages/repository/addTransactionRepo.dart';
import 'package:financhio/models/userModel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/pages/mainScreen.dart';
import 'common/widegets/error_page.dart';
import 'common/widegets/loading.dart';
String? selectedBank;

class HomePage extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const HomePage());
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
    int _selectedIndex = 0;
    // String? selectedBank;
  final List<Widget>_pages=[
 const   MainScreen(),
 const   TransactionScreen(),
 
 const  AddVarTransaction(),
  FinancialReport(),
 
  ];
   List<String?>? bankList=[];
 
   void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
  @override
  void initState() {
  
   WidgetsBinding.instance!.addPostFrameCallback((_) {
      getBankList();
    });
     SharedPreferences.getInstance().then((prefs) {
    setState(() {
      selectedBank = prefs.getString('selectedBank');
   
    });
  
  });
  
    super.initState();

  }
  void getBankList()async{
    bankList=
      await ref.watch(addTransactionProvider).selectBankForGod(context);
      print(bankList);
      setState(() {
        
      });
  }
  /*void pleaseSelectBank(BuildContext context) async {
  List<String?>? bankList =
      await ref.watch(addTransactionProvider).selectBankForGod(context);

  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? storedBank = prefs.getString('selectedBank') ?? bankList?[0];

  selectedBank = await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Select'),
        content: DropdownButton<String>(
          value: storedBank, // Set the initial selected value
          items: bankList!.map((String? bank) {
            return DropdownMenuItem<String>(
              value: bank,
              child: Text(bank!),
            );
          }).toList(),
          onChanged: (String? selectedValue) {
            // Handle the selection change
            setState(() {
              storedBank = selectedValue;
              //selectedBank=selectedValue;
            });
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              prefs.setString('selectedBank', storedBank ?? '');
              Navigator.pop(context, storedBank);
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
  setState(() {});
  print(selectedBank);
}*/

  @override
  Widget build(BuildContext context) {
     
  ref.watch(userDataAuthProvider);
    return FutureBuilder(
      future: ref.watch(mySelectedBankProvider),
      builder: (context,snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return Loader();
        }
        selectedBank=snapshot.data;
        return Consumer(
          builder: (context,watch,_) {
          //  final userData=ref.watch(userDataAuthProvider);
           
              return  StreamBuilder(
                stream: ref.watch(addTransactionProvider).addTransactionRepo.getUserData(),
                builder: (context,snapshot1) {
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Loader();
                  }
                  final user=snapshot1.data;
                  if(user==null){
                    return const Loader();
                  }
                  return Scaffold(
            appBar:AppBar(
          backgroundColor: Pallete.whiteColor,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return
                  ProfilePage();
                    }));
                  },
                  child: Container(
                    height: 42,
                    width: 42,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      backgroundImage: NetworkImage(user!.profilePic),
                    ),
                  ),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: InkWell(
                  onTap: ()async{
             
            
                  },
                  child: Container(
                    height: 40,
                    width: 107,
                    decoration: BoxDecoration(
                      border: Border.all(color: Pallete.purpleColor, width: 0.5),
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Expanded(
                          child: DropdownButton(
                            hint: Text("Select"),
                            value: selectedBank,
                            dropdownColor: Pallete.whiteColor,
                            icon: Icon(Icons.arrow_drop_down,color: Pallete.backgroundColor,),
                            isExpanded: false,
                            items:bankList!.map((String? bank) {
                    return DropdownMenuItem<String>(
                      value: bank,
                      child: Text(bank!),
                    );
                  }).toList(),
                  onChanged: (newValue)async{
                    setState(() {
                      selectedBank=newValue;
                    });
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                     prefs.setString('selectedBank', selectedBank ?? '');
                        ref.watch(mySelectedBankProvider.notifier).update((state)async {
                          return
                          selectedBank!;});

                  },
                              
                            
                          )
                       
                    ),]
                    ),
                  ),
            ),
          ),
        ),
            body: IndexedStack(
                  children: _pages,
                  index: _selectedIndex,
        
            ),
          
            bottomNavigationBar: BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home,size: 32,),
                      label: 'Home',
        
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.compare_arrows_sharp,size: 32,),
                      label: 'Transaction',
                    ),
                     BottomNavigationBarItem(
                      icon: Icon(Icons.add,size: 32,),
                      label: 'Add',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.bar_chart,size: 32,),
                      label: 'Financial Report',
                    ),
                     
                  ],
                  currentIndex: _selectedIndex,
                  selectedItemColor: Pallete.purpleColor,
                  unselectedItemColor: Color.fromARGB(255, 113, 113, 113),
                  onTap: _onItemTapped,
            ),
            
          );
                }
              );
          }
              );
      }
        );
      }
        }
        
              
            
  
          
        
      
    
  
  





