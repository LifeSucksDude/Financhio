import 'dart:io';

import 'package:financhio/constants/imageconstant.dart';
import 'package:flutter/material.dart';

class DonePage extends StatelessWidget {
  const DonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 128,
              width: 128,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(ImageConstants.succesLogo))
              ),
            ),
            Text('Success!',style: TextStyle(fontSize: 24),)
          ],
        ),
      ),
    );
  }
}