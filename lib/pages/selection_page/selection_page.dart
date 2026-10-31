import 'package:files/data/app_info_model.dart';
import 'package:files/pages/settings_page/accessibility_page.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/app_service.dart';
import 'package:flutter/material.dart';

List<AppInfoModel> selectedApps = [];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<AppInfoModel> apps = [];
  bool isLoading = true;
  
  int maxPick = 1;

  Future<void> loadApps() async {
    final result = await AppService.getApps();

    setState(() {
      apps = result;
      isLoading = false;
    });

  }

  // fungsi yang dipanggil sekali saat awal masuk widget scaffold
  @override
  void initState() {
    super.initState();
    loadApps();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),

      
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B),
        foregroundColor: Colors.white,
        elevation: 8,
        title: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            "Pick Any App",
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        actions: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 20),
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: selectedApps.length == maxPick
                  ? Colors.green
                  : Colors.blueAccent,
            ),
            child: TextButton(
              onPressed: selectedApps.length == maxPick
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CustomizeSelectedApps();
                          },
                        ),
                      );
                    }
                  : null, // matikan kalau belum 2
              child: Text(
                selectedApps.length == maxPick
                    ? "Next"
                    : "${selectedApps.length}/$maxPick",
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: 
          isLoading
          ? Container(
            alignment: Alignment(0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: Colors.white,),
                SizedBox(height: 20,),
                Text(
                  'Please wait, this might take a few seconds',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  )
                )
              ],
            ),
          )

          : ListView.builder(
              itemCount: apps.length,
              itemBuilder: (context, index) {
                final app = apps[index];
            
                return ListTile(
                  // show the icon
                  leading: app.icon != null
                  ? Image.memory(app.icon!, width: 30, height: 30,)
                  : null,

                  // show app name
                  title: Text(
                    app.appName,
                    style: GoogleFonts.inter(
                      color: Color(0xFFE2E8F0),
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    )),
                  
                  // show the package name
                  subtitle: Text(
                    app.packageName,
                    style: GoogleFonts.inter(
                      color: Color(0xFFE2E8F0),
                      fontSize: 12,
                    )),
                  
                  trailing: Checkbox(
                    value: app.isSelected,
                    activeColor: Colors.blue,
                    onChanged: 

                      // kalau sudah 2 dipilih dan app ini BELUM dipilih
                      selectedApps.length >= maxPick && !app.isSelected
                          ? null // disable checkbox
                          : (newValue) {
                              setState(() {
                                app.isSelected = newValue ?? false;

                                if (app.isSelected) {
                                  selectedApps.add(app);
                                } else {
                                  selectedApps.remove(app);
                                }

                              });
                            },
                  ),
                );
              }
            ),
          
      ),
    );

  }
}