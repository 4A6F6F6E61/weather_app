import 'package:weather_app/navigator_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            navigatorScaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Text('About'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Weather App', style: GoogleFonts.inter(fontSize: 30)),
                  SizedBox(height: 10),
                  Text(
                    'A simple weather application built with Flutter by 4A6F6F6E61.',
                    style: GoogleFonts.inter(fontSize: 18),
                  ),
                  TextButton(
                    onPressed: () {
                      showLicensePage(context: context);
                    },
                    child: Text("Licenses"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
