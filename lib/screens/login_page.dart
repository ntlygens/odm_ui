import 'package:flutter/material.dart';
import 'package:odm_ui/constants.dart';
import 'package:odm_ui/screens/register_page.dart';
import 'package:odm_ui/widgets/custom_btn.dart';
import 'package:odm_ui/widgets/custom_input.dart';

class LoginPage extends StatefulWidget {
  // const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // bool open = false;
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
      // resolves the renderflex overflow issue
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
                  "Welcome User \nLogin to your account",
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
                    dText: "Login",
                    onPressed: () {
                      _alertDialogBuilder();
                      print("clicked the Login Btn");
                    },
                    outlineBtn: false,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  // top: 6,
                  bottom: 16,
                ),
                child: CustomBtn(
                  dText: "Create New Account",
                  onPressed: () {
                    // WidgetsBinding.instance!.addPostFrameCallback((_) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage()
                        ),
                      );
                    // });
                    print ("clicked the create act btn");
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
