import 'package:financhio/Theme/pallete.dart';
import 'package:flutter/material.dart';

import '../../../constants/imageconstant.dart';
class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Pallete.greenColor,
      child:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

        
        Container(
          alignment: Alignment.centerLeft,
          height: 180,
          width: 180,
            decoration: BoxDecoration(
          image: 
          DecorationImage(image:AssetImage(ImageConstants.page2Intro))
        )),
        SizedBox(height: 100,),
        Padding(
          padding: const EdgeInsets.only(left:20.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('Why wait!',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30),)),
        ),
        SizedBox(height: 20,),
       Padding(
          padding: const EdgeInsets.only(left:20.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('Start saving today.',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
        ),
      ]),
    );
  }
}