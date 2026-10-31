import 'package:files/pages/selection_page/selection_page.dart';
import 'package:files/pages/intro_pages/page_1.dart';
import 'package:files/pages/intro_pages/page_2.dart';
import 'package:files/pages/intro_pages/page_3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color(0xFF0F172A),
      body: Stack(
        children: [
          // page view
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              Page1(),
              Page2(),
              Page3()
            ],
          ),

          // visual
          Container(
            alignment: Alignment(0, .8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // left arrow icon
                if (_currentPage > 0)
                IconButton(
                  color: Colors.white,
                  onPressed: (){
                    _controller.previousPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn
                      );
                  },
                  icon: Icon(CupertinoIcons.arrow_left_circle_fill, size: 40,)
                  ),

                // placeholder
                if (_currentPage == 0)
                SizedBox(width:56),

                SizedBox(width: 50,), // space
                

                // page indicator
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: WormEffect(
                    dotColor: Colors.white70,
                  ),
                  ),

                SizedBox(width: 50,), // space

                // right arrow icon
                if(_currentPage < 2)
                IconButton(
                  color: Colors.white,
                  onPressed: (){
                    _controller.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn
                      );
                  },
                  icon: Icon(CupertinoIcons.arrow_right_circle_fill, size: 40)
                  ),
                
                // start button
                if (_currentPage == 2)
                Container(
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(25)
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        return HomePage();
                      }));
                    },
                    child: Center(child: Text(
                      "Start",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                      )
                    ),
                  ),
                ),
                  

              ],
            )
          ),
 
        ],
      )
    );
  }
}