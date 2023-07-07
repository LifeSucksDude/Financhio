import 'package:financhio/Theme/pallete.dart';
import 'package:financhio/common/widegets/forAppOverall/customTextFieldApp.dart';
import 'package:financhio/constants/imageconstant.dart';
import 'package:financhio/constants/uiconstant.dart';
import 'package:financhio/common/widegets/forLogin/custextf.dart';
import 'package:financhio/features/authfeatures/controller/authcontroller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/widegets/forLogin/buttontype.dart';
import 'loginPageView.dart';

class SignUpPageView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SignUpPageView());
  const SignUpPageView({super.key});

  @override
  ConsumerState<SignUpPageView> createState() => _SignUpPageViewState();
}

class _SignUpPageViewState extends ConsumerState<SignUpPageView> {
  final appbar = UiConstant.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController=TextEditingController();
   @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }
void dotheFunctionSignUp(){
  String name=nameController.text;
  String email=emailController.text.trim();
  String password=passwordController.text.trim();
  if(email!=null && password!=null){
    ref.read(authControllerProvider).SignUpWithMail(context, name, email, password);
  }
}
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Financhio',style: TextStyle(color: Pallete.backgroundColor,fontSize: 23),),
        centerTitle: true,
      ),
      backgroundColor:Pallete.whiteColor ,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:20),
          child: Column(
              
           mainAxisAlignment: MainAxisAlignment.center,
            children: [
            const   SizedBox(height: 80,),
              CustomTextFieldApp(
                        controller: nameController,
                        hintText: 'Name',
                        enabledBorderColor: Pallete.greyColor,
                        focusedBOrderColor: Pallete.purpleColor,
                        backgroundColor: Pallete.whiteColor,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
               CustomTextFieldApp(
                        controller: emailController,
                       hintText: 'Email',
                       enabledBorderColor: Pallete.greyColor,
                       focusedBOrderColor: Pallete.purpleColor,
                       backgroundColor: Pallete.whiteColor,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      CustomTextFieldApp(
                          controller: passwordController, hintText: 'Password',enabledBorderColor: Pallete.greyColor,backgroundColor: Pallete.whiteColor,focusedBOrderColor: Pallete.purpleColor,),
                      SizedBox(
                        height: 40,
                      ),
                      Align(
                          alignment: Alignment.center,
                          child:ButtonTypeRect(
                            onTap: (){
                              dotheFunctionSignUp();
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
                              text: "Already a registered user?",
                              style: const TextStyle(fontSize: 16,color: Pallete.backgroundColor),
                              children: [
                            TextSpan(
                              text: " Login",
                              style: const TextStyle(
                                  color: Pallete.purpleColor, fontSize: 16),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(context, LoginPageView.route());
                                },
                            )
                          ]))
            
           
              
           
          ]),
        ),
      ),

    );
  }
}