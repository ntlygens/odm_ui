import 'package:cloud_firestore/cloud_firestore.dart';
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

  final _snackBar = SnackBar(content: Text("Product added to Cart"));

  Future _removeAllServiceProducts() async {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserID())
        .collection("SelectedService")
        .get()
        .then((snapshot) => {
          for (DocumentSnapshot ds in snapshot.docs){
              ds.reference.delete()
          },

          // snapshot.forEach((doc) => {
          //   doc.ref.delete()
          // })
          print(" all products removed!")
        });
  }

  Future _removeThisServiceProduct( prodID ) async {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserID())
        .collection("SelectedService")
        .where('prodID', isEqualTo: prodID)
        .get()
        .then((snapshot) => {
          // for (DocumentSnapshot ds in snapshot.docs){
          //   ds.reference.delete()
          // },
          print(" current product removed!")
        });
  }

  // async function getUserByEmail(email) {
  //   // Make the initial query
  //   const query = await db.collection('users').where('email', '==', email).get();
  //
  //   if (!query.empty) {
  //     const snapshot = query.docs[0];
  //     const data = snapshot.data();
  //   } else {
  //     // not found
  //   }
  //
  // }

  Future _unselectThisIcon(prodID) async {
    return  _firebaseServices.usersRef
        .doc(_firebaseServices.getUserID())
        .collection("SelectedService")
        .where('id', isEqualTo: prodID)
        // .where('prodID', isEqualTo: prodID)
        .get()
        .then((snapshot) => {
          for (DocumentSnapshot ds in snapshot.docs){
            print("product unselected!")
            // ds.reference.update({'isSelected': false})
          },
          // print("${snapshot.}product unselected!")
        },
    );
  }

  Future _unselectAllIcons(value) async {
    return _firebaseServices.productsRef
        .get()
        .then((value) => value.docs
        .forEach((element) {
          var docRef = _firebaseServices.productsRef
              .doc(element.id);

              docRef.update({'isSelected': false});
          },
        ),
    );
  }

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
                    List _docs = snapshot.data!['type'];
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
                                        color: Color(0xFFFF1E80)
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
                                        width: 90,
                                        height: 60,
                                        decoration: BoxDecoration(
                                            color: Color(0xFFDCDCDC),
                                            borderRadius: BorderRadius.circular(12)
                                        ),
                                        alignment: Alignment.center,
                                        /// ** // Reset DB Button Below IMPORTANT!!! //
                                        child: IconButton(
                                          onPressed: () {
                                            _unselectAllIcons(snapshot.data!.id);
                                            _removeAllServiceProducts();
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            size: 32.0,
                                          ),
                                        ),

                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () async {
                                            // await _addToCart();
                                            if(_alreadySelected == false) {
                                              ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                                            }

                                            Navigator.push(context, MaterialPageRoute(
                                              builder: (context) =>
                                                  ServiceProductsPage(),
                                            ));
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
                        ]
                    );
                  }

                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );

                }
            ),
            /*ActionBar(
              hasBackArrow: true,
              hasTitle: false,
              hasBackground: false,
            )*/
          ],
        )
    );
  }
}
