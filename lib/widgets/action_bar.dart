import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:odm_ui/constants.dart';
import 'package:odm_ui/screens/cart_page.dart';
import 'package:odm_ui/services/firebase_services.dart';

class ActionBar extends StatelessWidget {
  final String? title;
  final bool? hasBackArrow;
  final bool? hasTitle;
  final bool? hasBackground;

  ActionBar({ this.title, this.hasBackArrow, this.hasTitle, this.hasBackground });
  FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackArrow ?? false;
    bool _hasTitle = hasTitle ?? true;
    bool _hasBackground = hasBackground ?? true;

    return Container(
      decoration: BoxDecoration(
        // gradient: _hasBackground ? LinearGradient(
        //   colors: [
        //     Colors.white,
        //     Colors.white.withOpacity(0),
        //   ],
        //   begin: Alignment(0, 0),
        //   end: Alignment(0, 1)
        // ) : null
      ),
      padding: EdgeInsets.only(
        top: 40,
        left: 24,
        right: 24,
        bottom: 24
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_hasBackArrow)
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
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
            ),
          if (_hasTitle)
            Text(
              title ?? "Title here",
              style: Constants.boldHeading,
            ),

          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CartPage(),
                  ));
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
