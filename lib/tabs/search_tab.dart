import 'package:flutter/material.dart';
import 'package:odm_ui/widgets/action_bar.dart';

class SearchTab extends StatefulWidget {
  // SearchTab({});

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
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
