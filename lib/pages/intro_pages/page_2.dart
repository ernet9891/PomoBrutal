import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Sleep deprivation adds up?",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: Color(0xFFE2E8F0),
                  // fontWeight: FontWeight.bold,
                  fontSize: 38
                ),
              ),
            ),

            Image.asset("assets/img/intro2.png", width: double.infinity, height: 400, fit: BoxFit.cover,),

            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                textAlign: TextAlign.center,
                "It's not laziness. It's lost sleep.",
                style: GoogleFonts.inter(
                  color: Color(0xFFE2E8F0),
                  // fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            )
            
          ],
        )
      
    );
  }
}