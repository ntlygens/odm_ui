import 'package:flutter/material.dart';
import 'package:odm_ui/constants.dart';

class ActionBar extends StatelessWidget {
  final String title;
  final bool hasBackArrow;
  final bool hasTitle;
  final bool hasBackground;

  ActionBar({ this.title, this.hasBackArrow, this.hasTitle, this.hasBackground });

  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackArrow ?? false;
    bool _hasTitle = hasTitle ?? true;
    bool _hasBackground = hasBackground ?? true;

    return Container(
      decoration: BoxDecoration(
        gradient: _hasBackground ? LinearGradient(
          colors: [
            Colors.white,
            Colors.white.withOpacity(0),
          ],
          begin: Alignment(0, 0),
          end: Alignment(0, 1)
        ) : null
      ),
      padding: EdgeInsets.only(
        top: 56,
        left: 24,
        right: 24,
        bottom: 24
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_hasBackArrow)
            Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Image(
                  image: AssetImage(
                      "assets/images/back_arrow.png"
                  ),
                ),
            ),
          if (_hasTitle)
            Text(
              title ?? "Title here",
              style: Constants.boldHeading,
            ),

          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8)
            ),
            alignment: Alignment.center,
            child: Text(
              "0",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),


            ),
          )

        ],
      ),
    );
  }
}
