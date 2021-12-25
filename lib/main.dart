import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:odm_ui/screens/landing_page.dart';

void main() {
  runApp( MyApp() );
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.acmeTextTheme(
          Theme.of(context).textTheme,
        ),
        accentColor: Color(0xFFFF1E80),
      ),
      home: LandingPage(),
    );
  }
}
