import 'package:flutter/material.dart';

import '../../../constants/imageconstant.dart';
class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 255, 153, 85),
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
          DecorationImage(image:AssetImage(ImageConstants.page3Intro))
        )),
        SizedBox(height: 100,),
        Padding(
          padding: const EdgeInsets.only(left:20.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('Get Started',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30),)),
        ),
        SizedBox(height: 20,),
       Padding(
          padding: const EdgeInsets.only(left:20.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text("Let's plan together",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
        ),
      ]),
    );
  }
}