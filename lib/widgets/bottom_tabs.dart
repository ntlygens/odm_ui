import 'package:flutter/material.dart';

class BottomTabs extends StatefulWidget {
  final int selectedTab;
  final Function(int) tabClicked;
  BottomTabs({this.selectedTab, this.tabClicked});

@override
  State<BottomTabs> createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedTab ?? 0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.065),
            spreadRadius: 1,
            blurRadius: 30,
          )
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomTabsBtn(
            imagePath: "assets/images/baseline_home_black_24dp.png",
            selected: _selectedTab == 0 ? true : false,
            onPressed: () {
              widget.tabClicked(0);
            },
          ),
          BottomTabsBtn(
            imagePath: "assets/images/baseline_account_circle_black_18dp@2x.png",
            selected: _selectedTab == 1 ? true : false,
            onPressed: () {
              widget.tabClicked(1);;
            },
          ),
          BottomTabsBtn(
            imagePath: "assets/images/baseline_search_black_24dp@2x.png",
            selected: _selectedTab == 2 ? true : false,
            onPressed: () {
              widget.tabClicked(2);
            },
          ),
          BottomTabsBtn(
            imagePath: "assets/images/baseline_shopping_cart_black_24dp@2x.png",
            selected: _selectedTab == 3 ? true : false,
            onPressed: () {
              widget.tabClicked(3);
            },
          ),

        ],
      ),
    );
  }
}

class BottomTabsBtn extends StatelessWidget {
  final String imagePath;
  final bool selected;
  final Function onPressed;
  BottomTabsBtn({ this.imagePath, this.selected, this.onPressed });


  @override
  Widget build(BuildContext context) {
    bool _selected = selected ?? false;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: _selected ? Theme.of(context).accentColor : Colors.transparent,
              width: 2
            )
          )
        ),
        padding: EdgeInsets.symmetric(
          vertical: 28,
          horizontal: 16,
        ),
        child: Image(
          image: AssetImage(
            imagePath ?? "assets/images/baseline_home_black_24dp.png"
          ),
          width: 24,
          height: 24,
          color: _selected ? Theme.of(context).accentColor : Colors.black,
        ),
      ),
    );
  }
}
