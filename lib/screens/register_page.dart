import 'package:flutter/material.dart';
import 'package:odm_ui/constants.dart';
import 'package:odm_ui/widgets/custom_input.dart';
import 'login_page.dart';
import 'package:odm_ui/widgets/custom_btn.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // bool open = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    top: 24,
                  ),
                  child: const Text(
                    "Create a New Account",
                    textAlign: TextAlign.center,
                    style: Constants.boldHeading,
                  ),
                ),
                Column(
                  children: [
                    const CustomInput(
                      hintText: "youremail@example.com",
                    ),
                    const CustomInput(
                      hintText: "yourpassword",
                    ),
                    CustomBtn(
                      dText: "Create Account",
                      onPressed: () {
                        print("clicked the Register Btn");

                      },
                      outlineBtn: false,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16,
                  ),
                  child: CustomBtn(
                    dText: "Back To Login",
                    onPressed: () {
                      Navigator.of(context).pop();
                      // print("clicked the create acct btn");
                    },
                    outlineBtn: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
