import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color backgroundColor;
    final VoidCallback onTap;
  final String text;
 final Color textColor;
  const CustomButton({super.key, required this.backgroundColor, required this.onTap, required this.text, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:16.0),

      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16)
          ),
          child: Center(child: Text(text,style:TextStyle(color: textColor,fontSize: 16))),
        ),
      ),
    );
  }
}