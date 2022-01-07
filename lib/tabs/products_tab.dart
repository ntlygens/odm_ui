import 'package:flutter/material.dart';
import 'package:odm_ui/widgets/action_bar.dart';

class ProductsTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Center(
            child: Text("Products Tab"),
          ),
          ActionBar(
            title: "Products Page",
            hasTitle: false,
            hasBackArrow: true,
          ),
        ],
      ),
    );
  }
}
