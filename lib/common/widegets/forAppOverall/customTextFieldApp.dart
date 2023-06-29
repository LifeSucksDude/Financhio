// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextFieldApp extends StatelessWidget {
final   String hintText;
 final Color enabledBorderColor;
  final Color focusedBOrderColor;
 final  Color backgroundColor;
  final TextEditingController controller;
   CustomTextFieldApp({
    Key? key,
    required this.hintText,
    required this.enabledBorderColor,
   
    required this.backgroundColor, required this.controller, required this.focusedBOrderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(left: 16,right: 16),
        child: Container(
          height: 56,
          child: Center(
            child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
               focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide:  BorderSide(color: focusedBOrderColor,width: 2)
                
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: enabledBorderColor,width: 1),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 27),
              hintText: hintText,
              hintStyle: const TextStyle(fontSize: 18),
            fillColor: backgroundColor,
            filled: true
            ),
                
              ),
          ),
        ),
      );
    
  }
}
