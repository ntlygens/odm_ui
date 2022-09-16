import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:odm_ui/constants.dart';
import 'package:odm_ui/controllers/menu_controller.dart';
import 'package:odm_ui/screens/landing_page.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  // print('-- main');
  WidgetsFlutterBinding.ensureInitialized();
  // print('-- WidgetsFlutterBinding.ensureInitialized');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    // options: FirebaseOptions(
    //   apiKey: "XXX", // Your apiKey
    //   appId: "XXX", // Your appId
    //   messagingSenderId: "XXX", // Your messagingSenderId
    //   projectId: "XXX", // Your projectId
    // ),
  );
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
      title: 'OnDaMenu UI',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme
                .apply(bodyColor: Colors.white),
        ),
        canvasColor: secondaryColor,
        // textTheme: GoogleFonts.acmeTextTheme(
        //   Theme.of(context).textTheme,
        // ),
        // colorScheme: ColorScheme.fromSwatch()
        //     .copyWith(
        //       primary: Color(0xFFFF1E80),
        //       secondary: Color(0xFF1EFF22),
        //     ),
      ),
      // home: LandingPage(),

      // TODO: Uncomment when sidemenu is added
      home: MultiProvider(
          providers: [
            ChangeNotifierProvider<MenuController>(
              create: (context) => MenuController(),
            )
          ],
          child: LandingPage(),

      )
    );
  }
}
