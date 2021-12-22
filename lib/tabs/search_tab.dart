import 'package:flutter/material.dart';
import 'package:odm_ui/widgets/action_bar.dart';

class SearchTab extends StatelessWidget {
  // const SearchTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Center(
            child: Text("Search Tab"),
          ),
          ActionBar(
            title: "Search Page",
            hasTitle: true,
            hasBackArrow: true,
          ),
        ],
      ),
    );
  }
}
