import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:odm_ui/constants.dart';
import 'package:odm_ui/screens/cart_page.dart';
import 'package:odm_ui/services/firebase_services.dart';

import 'package:odm_ui/responsive.dart';

class ActionBar extends StatelessWidget {
  final String? title;
  final bool? hasBackArrow;
  final bool? hasTitle;
  final bool? hasBackground;
  final bool? hasIcon;

  ActionBar({ this.title, this.hasBackArrow, this.hasTitle, this.hasBackground, this.hasIcon });
  FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackArrow ?? false;
    bool _hasTitle = hasTitle ?? true;
    bool _hasBackground = hasBackground ?? true;
    bool _hasIcon = hasIcon ?? false;

    return Container(
      margin: EdgeInsets.only(left: defaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white12),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_hasIcon)
            Image.asset(
              "images/baseline_shopping_cart_black_24dp@2x.png",
              height: 21,
              width: 30,
              fit: BoxFit.fitWidth,
            ),
          if (!Responsive.isMobile(context) && _hasTitle)
            Text(
              title ?? "Title Here",
              style: Constants.boldHeadingWhite,
            ),
          if (Responsive.isMobile(context))
            Icon(Icons.keyboard_arrow_down),

          GestureDetector(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => CartPage(),
              //     ));
            },
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8)
              ),
              alignment: Alignment.center,
              child: StreamBuilder(
                stream: _firebaseServices.usersRef.doc(_firebaseServices.getUserID()).collection("Cart").snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  int _totalItems = 0;

                  if( snapshot.connectionState == ConnectionState.active ) {
                    if(snapshot.hasData) {
                        List _documents = snapshot.data!.docs;
                        _totalItems = _documents.length;
                      }
                    }

                  return Text(
                    "$_totalItems",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),

                  );
                }
              ),
            ),
          )

        ],
      ),
    );
  }
}
