import 'package:financhio/Theme/pallete.dart';
import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? text;
  const AuthTextField({super.key, required this.controller, this.text});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
         focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Pallete.purpleColor,width: 4)

        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color.fromARGB(255, 101, 101, 101),width: 2),
        ),
        contentPadding: const EdgeInsets.all(22),
        hintText: text,
        hintStyle: const TextStyle(fontSize: 18)

      ),

    );
  }
}