import 'package:financhio/Theme/pallete.dart';
import 'package:financhio/constants/imageconstant.dart';
import 'package:flutter/material.dart';

class UiConstant{
  static AppBar appBar(){
    return AppBar(
      elevation: 0,
      backgroundColor: Pallete.whiteColor,
      title: Center(
        child: Container(
          height: 100,
          decoration:const BoxDecoration(image: DecorationImage(image: AssetImage(ImageConstants.financhioLogo)),
        ),
        ),
      ),
      centerTitle: true,
    );
  }
}