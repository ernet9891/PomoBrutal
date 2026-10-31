import 'package:files/pages/selection_page/settings_selected_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomizeSelectedApps extends StatefulWidget {
  const CustomizeSelectedApps({super.key});

  @override
  State<CustomizeSelectedApps> createState() => _CustomizeSelectedAppsState();
}

class _CustomizeSelectedAppsState extends State<CustomizeSelectedApps> {

  bool btnPressed = false;
  static const platform = MethodChannel("accesibility");

  Future<void> openAccessibilitySettings() async {
    await platform.invokeMethod('openAccessibility');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF1E293B),
        foregroundColor: Colors.white,
        elevation: 8,
        centerTitle: true,
        title: Text(
          "Allow Accessibility",
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                textAlign: TextAlign.center,
                "To allow DeepLock to monitor and block selected apps during restricted hours, please enable Accessibility access.",
                style: GoogleFonts.inter(
                  color: Color(0xFFE2E8F0),
                  fontSize: 20
                ),
                ),
            ),

            SizedBox(height: 30,),

            accessibilityGuide(),

            SizedBox(height: 60,),

            // allow accesibility button
            SizedBox(
              width: 250,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  openAccessibilitySettings();
                  setState(() {
                    btnPressed = true;
                  });
                
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  "Allow Accessibility",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: const Color(0xFFE2E8F0),
                  ),
                ),
              ),
            ),

            // Continue Button
            SizedBox(height: 10),

            if (btnPressed == true)
            TextButton(

              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return SettingsSelectedApp();
                  })
                );
              },
              child: Text(
                "Continue to Deeplock >",
                style: GoogleFonts.inter(
                  color: Color(0xFFE2E8F0),
                  fontWeight: FontWeight.w500
                ),
              )
            ),

            SizedBox(height: 40)

          ],
        ),
      ),
    );
  }
}




Widget accessibilityGuide() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xFF0F172A),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          "Enable Accessibility Access",
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 20),

        buildStep("1. ", "Tap ", "Allow Accessibility ", additionalText: "Button"),
        buildStep("2. ", "Select ", "Downloaded Apps"),
        buildStep("3. ", "Choose ", "DeepLock"),
        buildStep("4. ", "Turn on ", "Use DeepLock"),
      ],
    ),
  );
}

Widget buildStep(String number, String normalText, String highlightedText,{String? additionalText}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: RichText(
      text: TextSpan(
        style: GoogleFonts.inter(
          fontSize: 16,
          color: const Color(0xFFE2E8F0),
        ),
        children: [

          TextSpan(
            text: number,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),

          TextSpan(text: normalText),

          TextSpan(
            text: highlightedText,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),

          TextSpan(text: additionalText),

        ],
      ),
    ),
  );
}