
import 'package:financhio/common/pages/profilepage.dart';
import 'package:financhio/common/pages/widgetsUi/updatepage.dart';
import 'package:financhio/common/widegets/loading.dart';
import 'package:financhio/features/forAddingProfile/navAddAccount.dart';
import 'package:financhio/features/trasactionpages/controller/addtransactionController.dart';
import 'package:financhio/features/trasactionpages/views/expense.dart';
import 'package:financhio/features/trasactionpages/views/income.dart';
import 'package:financhio/features/trasactionpages/views/smsStat.dart';
import 'package:financhio/firebase_options.dart';
import 'package:financhio/homeview.dart';
import 'package:financhio/screens/welcomescreens/onboardingPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/widegets/error_page.dart';
import 'features/authfeatures/controller/authcontroller.dart';
import 'features/authfeatures/views/signUpPageView.dart';
import 'features/forAddingProfile/addProfile.dart';
int? inintScreen;
int? initScreen2;
int? initScreen3;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences _preferences=await SharedPreferences.getInstance();
  inintScreen=  _preferences.getInt('initScreen');
  initScreen2=_preferences.getInt('initScreen2');
  initScreen3=_preferences.getInt('initScreen3');
  await _preferences.setInt('initScreen', 1);
  print(inintScreen);

 await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp( const ProviderScope(child:  MyApp()));
}

class MyApp extends ConsumerWidget {
  
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
   
    return FutureBuilder(
      future: ref.watch(addTransactionProvider).addBankList(),
      builder: (context,snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return Loader();
        }
        List<String>? bankList=snapshot.data;
        print(bankList);
        return MaterialApp(
          title: 'Financhio',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
           
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          
          home:
       
        ref.watch(userDataAuthProvider ).when(data: (user){
            if( inintScreen==null){
              print(inintScreen);
              return   OnBoardingScreens();
            }
            else if(user==null && inintScreen==1 ){
              return SignUpPageView();
            }
            else if(inintScreen==1 && user!=null && initScreen2==null){
               return UserInformation();
            }
            else if(inintScreen==1  && bankList!.isEmpty && user!=null&& initScreen2==1){
                return AddAccountPage();
            }
            else
            if(user!=null && inintScreen==1 && bankList!.isNotEmpty && initScreen2==1){
              return  HomePage();
            }

          }, error: (error,stackTrace)=>ErrorPage(error: error.toString()), loading:()=> const LoadingPage()) 
        );
      }
    );
  }
}

