import 'package:flutter/material.dart';
import 'package:odm_ui/constants.dart';

class HomePage extends StatefulWidget {
  // const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Home Page!",
          style: Constants.regHeading,
        ),
      ),
    );
  }
}
