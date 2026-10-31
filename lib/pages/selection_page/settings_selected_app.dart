import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'selection_page.dart';



class SettingsSelectedApp extends StatefulWidget {
  const SettingsSelectedApp({super.key});

  @override
  State<SettingsSelectedApp> createState() => _SettingsSelectedAppState();
}

class _SettingsSelectedAppState extends State<SettingsSelectedApp> {
  static const platform = MethodChannel("block_selected_app");

  bool _isSwitched = false;

  List<String> selectedAppsPackageNames() {
    return selectedApps.map(
      (app) => app.packageName
      ).toList();
  }


  Future<void> sendBlockedAppstoNative() async {
    List<String> package = selectedAppsPackageNames();
    await platform.invokeMethod("blockApp", package);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0F172A),
      appBar: AppBar(
        elevation: 8,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF1E293B),
        title: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            "Configuration",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w800,
              color: Colors.white
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // app name
            Text(
              selectedApps[0].appName,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w600
              ),
            ),

            SizedBox(height: 30,),

            // icon and the background
            Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(25)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (selectedApps[0].icon != null)
                  Image.memory(selectedApps[0].icon!, width: 160, height: 160,)
                  else 
                  SizedBox()
                ],
              ),
            ),

            SizedBox(height: 30),

             Switch(
              activeThumbColor: Colors.green,
              value: _isSwitched,
              onChanged: (newValue) {
                setState(() {
                  _isSwitched = newValue;
                  sendBlockedAppstoNative();
                });
              },
            )
          ],
        ),
      ),
    );
  }
}