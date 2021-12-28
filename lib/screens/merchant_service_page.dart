import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:odm_ui/widgets/action_bar.dart';
import 'package:odm_ui/widgets/category_types.dart';
import 'package:odm_ui/widgets/image_swipe.dart';

import '../constants.dart';

class MerchantServicePage extends StatefulWidget {
  final String productID;
  MerchantServicePage({this.productID});

  @override
  _MerchantServicePageState createState() => _MerchantServicePageState();
}

class _MerchantServicePageState extends State<MerchantServicePage> {
  final CollectionReference _servicesRef =
    FirebaseFirestore.instance.collection("Services");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: _servicesRef.doc(widget.productID).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                // Firebase doc data map
                Map<String, dynamic> documentData = snapshot.data.data();

                // List of images
                List serviceImageList = documentData['images'];
                // List of types
                List serviceType = documentData['type'];

                return ListView(
                  padding: EdgeInsets.all(0),
                  children: [
                    ImageSwipe(imageList: serviceImageList),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 24
                      ),
                      child: Text(
                          "${documentData['name']}" ?? "Category Name",
                        style: Constants.boldHeading,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 24
                      ),

                      child: Text(
                          "${documentData['desc']}" ?? "Category Description",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 24,
                          bottom: 0
                      ),
                      child: Text(
                          "Service Categories",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).accentColor,
                        )

                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20
                      ),
                      child: CategoryTypes(
                        categoryTypeList: serviceType,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color(0xFFDCDCDC),
                              borderRadius: BorderRadius.circular(12)
                            ),
                            alignment: Alignment.center,
                            child: Image(
                              image: AssetImage(
                                "assets/images/bookmark_icon.png",
                              ),
                              fit: BoxFit.contain,
                              height: 26,
                              // width: 42

                            ),

                          ),
                          Expanded(
                            child: Container(
                              height: 65,
                              margin: EdgeInsets.only(
                                left: 16
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Select Category",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                );
              }

              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );

            }
          ),
          ActionBar(
            hasBackArrow: true,
            hasTitle: false,
            hasBackground: false,
          )
        ],
      )
    );
  }
}
