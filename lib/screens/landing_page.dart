import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:odm_ui/constants.dart';
import 'package:odm_ui/screens/home_page.dart';
import 'package:odm_ui/screens/login_page.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("Error: $snapshot.error"),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, streamSnapshot) {
                if (streamSnapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error: $streamSnapshot.error"),
                    ),
                  );
                }

                if (streamSnapshot.connectionState == ConnectionState.active) {
                  // get the user
                  User? _user = streamSnapshot.data as User?;

                  // if user not logged in
                  if(_user == null) {
                    return LoginPage();
                  } else {
                    // user is looged in go to home page
                    return HomePage();
                  }
                }

                return const Scaffold(
                  body: Center(
                    child: Text(
                      "Checking Authentication.... ",
                      style: Constants.regHeading,
                    ),
                  ),
                );
              },
            );

            // return HomePage();
            /*return Scaffold(
              body: Container(
                child: const Center(
                  child: Text(
                    "Firebase App Initialized!",
                    style: Constants.regHeading,
                  ),
                ),
              ),
            );*/
          }

          return const Scaffold(
            body: Center(
              child: Text(
                "Initializing App.... ",
              ),
            ),
          );
        });
  }
}
