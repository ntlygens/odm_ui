import 'package:flutter/material.dart';
import 'package:odm_ui/constants.dart';
import 'package:odm_ui/screens/register_page.dart';
import 'package:odm_ui/widgets/custom_btn.dart';
import 'package:odm_ui/widgets/custom_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // bool open = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    const CustomInput(
                      hintText: "youremail@example.com",
                    ),
                    const CustomInput(
                      hintText: "yourpassword",
                    ),
                    CustomBtn(
                      dText: "Login",
                      onPressed: () {
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()
                        ),
                      );

                      /*MaterialPageRoute materialPageRoute = MaterialPageRoute (
                        builder: (context) => const RegisterPage()
                      );
                      Navigator.of(context).push(materialPageRoute);*/ // error on of(context)
                      // Navigator.of(context).pushNamed("./RegisterPage"); // error on of(context)
                      // open = false;

                      /*WidgetsBinding.instance!.addPostFrameCallback((_) {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => RegisterPage()));
                      });*/
                      
                      // print ("clicked the create act btn");
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
