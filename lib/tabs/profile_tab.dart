import 'package:flutter/material.dart';
import 'package:odm_ui/widgets/action_bar.dart';

class ProfileTab extends StatelessWidget {
  // const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Center(
            child: Text("Profile Tab"),
          ),
          ActionBar(
            title: "Profile Page",
            hasTitle: false,
            hasBackArrow: true,
          ),
        ],
      ),
    );
  }
}
