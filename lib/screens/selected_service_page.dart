import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:odm_ui/screens/service_products_page.dart';
import 'package:odm_ui/services/firebase_services.dart';
import 'package:odm_ui/widgets/action_bar.dart';
import 'package:odm_ui/widgets/category_types.dart';
import 'package:odm_ui/widgets/image_swipe.dart';

import '../constants.dart';

class SelectedServicePage extends StatefulWidget {
  final String serviceID;
  SelectedServicePage({required this.serviceID});

  @override
  _SelectedServicePageState createState() => _SelectedServicePageState();
}

class _SelectedServicePageState extends State<SelectedServicePage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  // User -> userID -> Cart ->

  String _selectedCategoryType = "0";

  Future _addToCart() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserID())
        .collection("Cart")
        .doc(widget.serviceID)
        .set({ "type": _selectedCategoryType });
  }

  final _snackBar = SnackBar(content: Text("Product added to Cart"));

  @override
  Widget build(BuildContext context) {
    bool _alreadySelected = true;

    return Scaffold(
        body: Stack(
          children: [
            FutureBuilder<DocumentSnapshot>(
                future: _firebaseServices.servicesRef.doc(widget.serviceID).get(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Scaffold(
                      body: Center(
                        child: Text("Error: ${snapshot.error}"),
                      ),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    /// ** // List _docs = snapshot.data['type'];
                    List _docs = snapshot.data!['type'];
                    // List _documents = _docs.docs;
                    // print("snapshot: ${snapshot.data['type'][0]}");
                    /// ** print("snapshot: ${_docs[0]}");
                    // Firebase doc data map
                    // ** // Map<String, dynamic> documentData = snapshot.data.data();
                    // Map<String, dynamic> documentData = snapshot.data['type'].data();

                    // List of images
                    // List serviceImageList = documentData['images'];
                    // List of types
                    // List serviceType = documentData['type'];
                    // set default value
                    // _selectedCategoryType = serviceType[0];

                    return ListView(
                        padding: EdgeInsets.all(0),
                        children: [
                          Column(
                              children: [
                                ImageSwipe(imageList: snapshot.data!['images']),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 24
                                  ),
                                  child: Text(
                                    "${snapshot.data['name']}",
                                    style: Constants.boldHeading,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 24
                                  ),

                                  child: Text(
                                    "${snapshot.data['desc']}",
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
                                    categoryTypeList: _docs,
                                    serviceCategoryName: snapshot.data['name'],
                                    serviceCategoryID: snapshot.data.id,

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
                                          height: 22,
                                          // width: 42

                                        ),

                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () async {
                                            // await _addToCart();
                                            if(_alreadySelected == false) {
                                              Scaffold.of(context).showSnackBar(_snackBar);
                                            }

                                            Navigator.push(context, MaterialPageRoute(
                                              builder: (context) =>
                                                  ServiceProductsPage(),
                                            )
                                            );
                                            // print("Product Added");
                                          },
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
                                              "View Selected",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )

                              ]
                          )
                          /*Padding(
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
                                              serviceCategoryName: snapshot.data['name'],
                                              serviceCategoryID: snapshot.data.id,

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
                                                    height: 22,
                                                    // width: 42

                                                  ),

                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      // await _addToCart();
                                                      if(_alreadySelected == false) {
                                                        Scaffold.of(context).showSnackBar(_snackBar);
                                                      }

                                                      Navigator.push(context, MaterialPageRoute(
                                                        builder: (context) =>
                                                            ServiceProductsPage(),
                                                      )
                                                      );
                                                      // print("Product Added");
                                                    },
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
                                                        "View Selected",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w600
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )*/
                        ]


                      /*children: [
                                          Container(
                                            child: Text(
                                                "text: ${docData.data!['name']}"
                                            ),
                                          )
                                        ],*/

                      /*child: Container(
                                          height: 300,
                                          width: double.infinity,
                                          alignment: Alignment.center,
                                          child: Text(
                                              "text: ${docData.data!['name']}"
                                          ),
                                        ),*/
                    );


                    /*return ListView.builder(
                      // itemCount: snapshot.data!.id.length,
                      *//*itemBuilder: (context, index) {
                        return Container(
                          child: Text(
                            "id: ${snapshot.data['type'][index]}"
                          ),
                        );
                      },*/
                    /*
                      itemBuilder: (context, index) {
                        return FutureBuilder(
                          // future: snapshot.data!.doc,
                          future: _firebaseServices.productsRef
                            .doc("${snapshot.data['type'][index]}")
                            .get(),
                            builder: (context, AsyncSnapshot docData) {
                              if(docData.hasError){
                                return Scaffold(
                                  body: Center(
                                    child: Text("Error: ${docData.error}"),
                                  ),
                                );
                              }

                              if(docData.connectionState == ConnectionState.done){
                                if(docData.hasData){
                                  List serviceImageList = snapshot.data!['images'];
                                  // docData.data!.map((daDoc) {
                                    return ListView(
                                      padding: EdgeInsets.all(0),
                                      children: [
                                        Column(
                                            children: [
                                              ImageSwipe(imageList: serviceImageList),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 24
                                                ),
                                                child: Text(
                                                  "${docData.data['name']}",
                                                  style: Constants.boldHeading,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 24
                                                ),

                                                child: Text(
                                                  "${docData.data['desc']}",
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
                                                  serviceCategoryName: snapshot.data['name'],
                                                  serviceCategoryID: snapshot.data.id,

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
                                                        height: 22,
                                                        // width: 42

                                                      ),

                                                    ),
                                                    Expanded(
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          // await _addToCart();
                                                          if(_alreadySelected == false) {
                                                            Scaffold.of(context).showSnackBar(_snackBar);
                                                          }

                                                          Navigator.push(context, MaterialPageRoute(
                                                            builder: (context) =>
                                                                ServiceProductsPage(),
                                                          )
                                                          );
                                                          // print("Product Added");
                                                        },
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
                                                            "View Selected",
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w600
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )

                                            ]
                                        )
                                        *//*Padding(
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
                                              serviceCategoryName: snapshot.data['name'],
                                              serviceCategoryID: snapshot.data.id,

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
                                                    height: 22,
                                                    // width: 42

                                                  ),

                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      // await _addToCart();
                                                      if(_alreadySelected == false) {
                                                        Scaffold.of(context).showSnackBar(_snackBar);
                                                      }

                                                      Navigator.push(context, MaterialPageRoute(
                                                        builder: (context) =>
                                                            ServiceProductsPage(),
                                                      )
                                                      );
                                                      // print("Product Added");
                                                    },
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
                                                        "View Selected",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w600
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )*/
                    /*
                                      ]


                                        *//*children: [
                                          Container(
                                            child: Text(
                                                "text: ${docData.data!['name']}"
                                            ),
                                          )
                                        ],*/
                    /*

                                        *//*child: Container(
                                          height: 300,
                                          width: double.infinity,
                                          alignment: Alignment.center,
                                          child: Text(
                                              "text: ${docData.data!['name']}"
                                          ),
                                        ),*/
                    /*
                                    );
                                  // });
                                  // print("text: ${docData.data['name']}");
                                }
                              }

                              return Scaffold(
                                body: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                        );
                      },

                      *//*children: [
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
                            serviceCategoryName: snapshot.data['name'],
                            serviceCategoryID: snapshot.data.id,

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
                                  height: 22,
                                  // width: 42

                                ),

                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    // await _addToCart();
                                    if(_alreadySelected == false) {
                                      Scaffold.of(context).showSnackBar(_snackBar);
                                    }

                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                          ServiceProductsPage(),
                                    )
                                    );
                                    // print("Product Added");
                                  },
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
                                      "View Selected",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],*//*
                    );*/
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
