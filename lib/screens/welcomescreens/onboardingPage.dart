import 'package:financhio/screens/welcomescreens/intropages/page1.dart';
import 'package:financhio/screens/welcomescreens/intropages/page2.dart';
import 'package:financhio/screens/welcomescreens/intropages/page3.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreens extends StatefulWidget {
  const OnBoardingScreens({super.key});

  @override
  State<OnBoardingScreens> createState() => _OnBoardingScreensState();
}

class _OnBoardingScreensState extends State<OnBoardingScreens> {
  //controller for keeping the track
  PageController _controller=PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(

        children:[ PageView(
          controller: _controller,
          children: [
            IntroPage1(),
            IntroPage2(),
            IntroPage3()
          ],
        ),
        Container(
          padding: EdgeInsets.only(bottom: 45),
          alignment: const Alignment(0,1),
          child: SmoothPageIndicator(controller: _controller, count: 3))
        ]
      ),
    );
  }
}