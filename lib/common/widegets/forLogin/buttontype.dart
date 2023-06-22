import 'package:financhio/Theme/pallete.dart';
import 'package:flutter/material.dart';

class ButtonTypeRect extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final Color backgroundColor;
  final Color textColors;
  const ButtonTypeRect({super.key, required this.onTap, required this.label, required this.backgroundColor, required this.textColors});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onTap, 
     style: ElevatedButton.styleFrom(
    backgroundColor:Pallete.purpleColor , 
    elevation: 0,
    
    minimumSize: Size(343, 56),
    maximumSize: Size(343, 56),
     shape:
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0), // Adjust the border radius as desired
      
    ),
    
   
    // Set the desired background color
  ),
    child: Text(label,style: TextStyle(color: textColors,fontSize: 16 ),
    
    ));
  }
}