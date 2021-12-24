import 'package:flutter/material.dart';
import 'package:odm_ui/widgets/action_bar.dart';

class ShoppingCartTab extends StatelessWidget {
  // const ShoppingCartTab({Key? key}) : super(key: key);

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
