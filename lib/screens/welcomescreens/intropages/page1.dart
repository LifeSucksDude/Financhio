// ignore_for_file: prefer_const_constructors

import 'package:financhio/Theme/pallete.dart';
import 'package:financhio/constants/imageconstant.dart';
import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color:Pallete.purpleColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

        
        Container(
          alignment: Alignment.centerLeft,
          height: 180,
          width: 180,
            decoration: BoxDecoration(
          image: 
          DecorationImage(image:AssetImage(ImageConstants.page1Intro))
        )),
        SizedBox(height: 100,),
        Padding(
          padding: const EdgeInsets.only(left:20.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('Welcome to Financhio!',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30),)),
        ),
        SizedBox(height: 20,),
       Padding(
          padding: const EdgeInsets.only(left:20.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('All you need is a finance expert',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
        ),
      ]),
    );
  }
}
