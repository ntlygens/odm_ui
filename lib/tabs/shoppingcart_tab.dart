import 'package:flutter/material.dart';
import 'package:odm_ui/widgets/action_bar.dart';

class ShoppingCartTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Center(
            child: Text(
              "Cart Tab"
            ),
          ),
          ActionBar(
            title: "Shopping Cart",
            hasTitle: true,
            hasBackArrow: true,
          ),
        ],
      ),
    );
  }
}
