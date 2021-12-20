import 'package:flutter/material.dart';
import 'package:odm_ui/constants.dart';
import 'package:odm_ui/widgets/custom_input.dart';
import 'login_page.dart';
import 'package:odm_ui/widgets/custom_btn.dart';

class RegisterPage extends StatefulWidget {
  // const RegisterPage({Key? key}) : super(key: key);
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // bool open = false;
  // alert box for error display
  Future<void> _alertDialogBuilder() async {
    return showDialog(
        context: context,
        // only dismissable by clicking button
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Container (
              child: Text("Random text placeholder"),
            ),
            actions: [
              FlatButton(
                  child: Text("Close Dialog"),
                  onPressed: () {
                      Navigator.pop(context);
                  },
              )
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
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
                  CustomInput(
                    hintText: "youremail@example.com",
                  ),
                  CustomInput(
                    hintText: "yourpassword",
                  ),
                  CustomBtn(
                    dText: "Create Account",
                    onPressed: () {
                      _alertDialogBuilder();
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
                    Navigator.pop(context);
                   /* WidgetsBinding.instance!.addPostFrameCallback((_) {
                      Navigator.of(context).pop();
                    });*/
                    // print("clicked the create acct btn");
                  },
                  outlineBtn: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
