
import 'package:financhio/common/widegets/loading.dart';
import 'package:financhio/features/forAddingProfile/navAddAccount.dart';
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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences _preferences=await SharedPreferences.getInstance();
  inintScreen=  _preferences.getInt('initScreen');
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
    return MaterialApp(
      title: 'Financhio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      
      home:HomePage()
      
   /*  ref.watch(userDataAuthProvider ).when(data: (user){
        if( inintScreen==null){
          print(inintScreen);
          return   OnBoardingScreens();
        }
        else if(user==null && inintScreen==1){
          return SignUpPageView();
        }
        else {
          return const UserInformation();
        }

      }, error: (error,stackTrace)=>ErrorPage(error: error.toString()), loading:()=> const LoadingPage()) */
    );
  }
}

