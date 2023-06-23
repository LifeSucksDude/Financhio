import 'package:financhio/features/authfeatures/views/signUpPageView.dart';
import 'package:financhio/homeview.dart';
import 'package:financhio/screens/welcomescreens/intropages/page1.dart';
import 'package:financhio/screens/welcomescreens/intropages/page2.dart';
import 'package:financhio/screens/welcomescreens/intropages/page3.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreens extends StatefulWidget {
  const OnBoardingScreens({super.key});

  @override
  State<OnBoardingScreens> createState() => _OnBoardingScreensState();
}

class _OnBoardingScreensState extends State<OnBoardingScreens> {
  
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  //controller for keeping the track
  final PageController _controller = PageController();
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView(
          onPageChanged: (index) {
            onLastPage = (index == 2);
            setState(() {
              
            });
          },
          controller: _controller,
          children: const [IntroPage1(), IntroPage2(), IntroPage3()],
        ),
        Container(
            padding:const  EdgeInsets.only(bottom: 45),
            alignment: const Alignment(0, 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                   _controller.animateToPage(
      2,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
                  },
                  child:Container(
                    height: 30,
                    width: 50,
                  
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 0, 0, 0)
                    ),
                    child:  Padding(
                      padding: const EdgeInsets.only(left:8.0,top: 3),
                      child: Text('skip',style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255),fontSize: 16),),
                    ))
                ),
                SmoothPageIndicator(controller: _controller, count: 3),
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return SignUpPageView();
                          }));
                        },
                        child: const Text('Done'),
                      )
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        
                         child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black
                            ),
                            child: const Icon(Icons.arrow_forward,color: Colors.white,),)),
                      
              ],
            ))
      ]),
    );
  }
}
