import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:odm_ui/screens/landing_page.dart';

void main() async {
  // print('-- main');
  WidgetsFlutterBinding.ensureInitialized();
  // print('-- WidgetsFlutterBinding.ensureInitialized');
  await Firebase.initializeApp();
  // print('-- main: Firebase.initializeApp');
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
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(
              primary: Color(0xFFFF1E80),
              secondary: Color(0xFF1EFF22),
            ),
      ),
      home: LandingPage(),
    );
  }
}
