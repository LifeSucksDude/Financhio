import 'package:financhio/features/authfeatures/controller/authcontroller.dart';
import 'package:financhio/features/forAddingProfile/navAddAccount.dart';
import 'package:financhio/features/trasactionpages/controller/addtransactionController.dart';
import 'package:financhio/features/trasactionpages/views/smsStat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Theme/pallete.dart';
import '../widegets/error_page.dart';
import '../widegets/loading.dart';
import 'widgetsUi/updatepage.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
   
                return StreamBuilder(
                  stream: ref.watch(addTransactionProvider).addTransactionRepo.getUserData(),
                  builder: (context,snapshot) {
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return const Loader();
                    }
                    if(snapshot.data==null){
                      return Loader();
                    }
                    final data=snapshot.data;
                    return Scaffold(backgroundColor: Pallete.whiteColor,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new)),
          title: Text("Profile Page",style: TextStyle(color: Pallete.backgroundColor,fontWeight: FontWeight.w500),),
          centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
            children: [
              SizedBox(height: 20,),
             
                     Row(
                    children: [
                      Container(
                        height: 84,
                        width: 84,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Pallete.purpleColor,
                            width: 1,
                            
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(60))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: SizedBox(
                            height: 80,
                            width: 80,
                            child: CircleAvatar(
                              backgroundColor:Pallete.backgroundColor,
                              backgroundImage: NetworkImage(data!.profilePic) ,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5,),
                      Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Username',style: TextStyle(fontSize: 14,color: Pallete.greyColor),),
                       //   SizedBox(height: 5,),
                          Text("${data.name}",style: TextStyle(color: Pallete.backgroundColor,fontSize: 24,fontWeight: FontWeight.w700),)
                        ],

                      )
                    ],
                    
              ),
             
               SizedBox(height: 30,),
               GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                      return AddAccountPage();
                      }));
                    },
                     child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 90,
                      decoration: BoxDecoration(
                        color: Pallete.listColor,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              height: 52,
                              width: 52,
                              decoration: BoxDecoration(
                                color:Color.fromARGB(255, 210, 200, 255),
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(image: AssetImage("assets/images/wallet 3.png"))
                              ),
                              
                              
                            ),
                           
                          ),
                           Text('Add bank',style: TextStyle(color: Pallete.backgroundColor,fontSize: 16,fontWeight: FontWeight.w700,),),
                        ],
                      ),
                     ),
               ),
               SizedBox(height: 5,),
                     GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                      return UpdateAccountPage(url: data.profilePic);
                      }));
                    },
                     child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 90,
                      decoration: BoxDecoration(
                        color:Pallete.listColor,
                    //    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              height: 52,
                              width: 52,
                              decoration: BoxDecoration(
                                color:Color.fromARGB(255, 210, 200, 255),
                                borderRadius: BorderRadius.circular(16),
                                 image: DecorationImage(image: AssetImage("assets/images/settings.png"))
                              ),
                              
                            ),
                           
                          ),
                           Text('Edit Information',style: TextStyle(color: Pallete.backgroundColor,fontSize: 16,fontWeight: FontWeight.w700,),),
                        ],
                      ),
                     ),
               ),
                     SizedBox(height: 5,),
                    GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                      return AddStateMessage();
                      }));
                    },
                     child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 90,
                      decoration: BoxDecoration(
                        color:Pallete.listColor,
                    //    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              height: 52,
                              width: 52,
                              decoration: BoxDecoration(
                                color:Color.fromARGB(255, 210, 200, 255),
                                borderRadius: BorderRadius.circular(16)
                              ),
                              child: Icon(Icons.add_box_rounded,color: const Color.fromARGB(255, 246, 228, 227),),
                              
                            ),
                           
                          ),
                           Text('Add transaction through SMS',style: TextStyle(color: Pallete.backgroundColor,fontSize: 16,fontWeight: FontWeight.w700,),),
                        ],
                      ),
                     ),
               ),  SizedBox(height: 5,),
              GestureDetector(
  onTap: () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Are you sure you want to logout?"),
          actions: [
            ElevatedButton(
              onPressed: () {
                    ref.watch(addTransactionProvider).logoutUserforGod(data.uid, context);
              },
              child: Text("Log out"),
            ),
            ElevatedButton(
              onPressed: () {
                    Navigator.pop(context);
              },
              child: Text("No"),
            ),
          ],
        );
      },
    );
  },
  child: Container(
    width: MediaQuery.of(context).size.width,
    height: 90,
    decoration: BoxDecoration(
      color: Pallete.listColor,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
    ),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 190, 195),
              borderRadius: BorderRadius.circular(16),
               image: DecorationImage(image: AssetImage("assets/images/logout.png"))
            ),
          ),
        ),
        Text(
          'Logout',
          style: TextStyle(
            color: Pallete.backgroundColor,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  ),
),

              
      
             
            ],
          ),
      ),
        );
                  }
                );
  }
              
  
}