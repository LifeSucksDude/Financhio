import 'package:financhio/Theme/pallete.dart';
import 'package:financhio/common/pages/addvartrasaction.dart';
import 'package:financhio/common/pages/pagelist.dart';
import 'package:financhio/common/pages/profilepage.dart';
import 'package:financhio/common/pages/trasactionscreen.dart';
import 'package:financhio/common/pages/widgetsUi/appBar.dart';
import 'package:flutter/material.dart';

import 'common/pages/mainScreen.dart';

class HomePage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const HomePage());
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    int _selectedIndex = 0;
  final List<Widget>_pages=[
 const   MainScreen(),
 const   TransactionScreen(),
 const  AddVarTransaction(),
  const  ProfilePage()
  ];
   void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: MyAppBar(url: 'https://source.unsplash.com/user/wsanter'),
      body: IndexedStack(
        children: _pages,

      ),
     // bottomNavigationBar: ,
     
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
            icon: Icon(Icons.bar_chart,size: 32,),
            label: 'Financial Report',
          ),
            BottomNavigationBarItem(
            icon: Icon(Icons.add,size: 32,),
            label: 'Add',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Pallete.purpleColor,
        unselectedItemColor: Color.fromARGB(255, 113, 113, 113),
        onTap: _onItemTapped,
      ),
    );
  }
}




/* floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.white,
        focusColor: Colors.white,
        hoverColor: Colors.white,
        hoverElevation: 0,
        onPressed: (){

      },
      child: Container(
        height: 64,
        width: 64,
        decoration: BoxDecoration(
          color: Pallete.purpleColor,
          borderRadius: BorderRadius.circular(32),
          
          
        ),
        child: const Icon(Icons.add,color: Pallete.whiteColor,size: 32,),
      ),
      ),*/