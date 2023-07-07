import 'package:flutter/material.dart';

import '../../../Theme/pallete.dart';

class SelectableItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 24,
        width: 80,
       // padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ?Pallete.paleColor : Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color:  Pallete.backgroundColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}