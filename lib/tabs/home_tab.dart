import 'package:flutter/material.dart';
import 'package:odm_ui/widgets/action_bar.dart';

class HomeTab extends StatelessWidget {

  // HomeTab({});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Center(
            child: Text("Home Tab"),
          ),
          ActionBar(
            title: "Home Page",
            hasBackArrow: false,
          ),
        ],
      ),
    );
  }
}
