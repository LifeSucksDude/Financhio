import 'package:financhio/features/authfeatures/views/signUpPageView.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Theme/pallete.dart';
import '../../../constants/uiconstant.dart';
import '../../../common/widegets/forLogin/buttontype.dart';
import '../../../common/widegets/forLogin/custextf.dart';
import '../controller/authcontroller.dart';

class LoginPageView extends ConsumerStatefulWidget {
   static route()=> MaterialPageRoute(builder: (context)=>const LoginPageView());
 
  const LoginPageView({super.key});

  @override
  ConsumerState<LoginPageView> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends ConsumerState<LoginPageView> {
   final appbar = UiConstant.appBar();
   final emailController = TextEditingController();
  final passwordController = TextEditingController();
   void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  void LogthisUser(){
     String email=emailController.text.trim();
  String password=passwordController.text.trim();
  if(email!=null && password!=null){
    ref.read(authControllerProvider).LoginUser(email, password, context);
  }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Financhio'),
      ),
      
    body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:20),
          child: Column(
              
           mainAxisAlignment: MainAxisAlignment.center,
            children: [
            const   SizedBox(height: 80,),
              
               AuthTextField(
                        controller: emailController,
                        text: 'Email',
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      AuthTextField(
                          controller: passwordController, text: 'Password'),
                      SizedBox(
                        height: 40,
                      ),
                      Align(
                          alignment: Alignment.center,
                          child:ButtonTypeRect(
                            onTap: (){
                              LogthisUser();
                            },
                            label: "Done",
                            backgroundColor: Pallete.purpleColor,
                            textColors: Pallete.whiteColor,
                          )),
                     
                      const SizedBox(
                        height: 40,
                      ),
                      RichText(
                          text: TextSpan(
                              text: "Don't have an account?",
                              style: const TextStyle(fontSize: 16,color: Pallete.backgroundColor),
                              children: [
                            TextSpan(
                              text: " Sign Up",
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 214, 15, 249), fontSize: 16),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(context,SignUpPageView.route());
                                },
                            )
                          ]))
            
           
              
           
          ]),
        ),
      ),
    );
  }
}