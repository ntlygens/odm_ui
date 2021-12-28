import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:odm_ui/constants.dart';
import 'package:odm_ui/screens/merchant_service_page.dart';
import 'package:odm_ui/widgets/action_bar.dart';

class HomeTab extends StatelessWidget {
  final CollectionReference _servicesRef =
    FirebaseFirestore.instance.collection("Services");
  // HomeTab({});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Center(
            child: Text("Home Tab"),
          ),
          FutureBuilder<QuerySnapshot>(
            future: _servicesRef.get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              // collection data to display
              if(snapshot.connectionState == ConnectionState.done) {
                // display data in listview
                return ListView (
                  padding: EdgeInsets.only(
                    top: 120,
                    bottom: 24,
                  ),
                  children: snapshot.data.docs.map((document) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                MerchantServicePage(
                                    productID: document.id
                                )
                        ));
                      },
                      child: Container(
                        // height: 225,
                        // width: double.infinity,
                        // alignment: Alignment.topCenter,
                        margin: EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 14,
                        ),
                        child: Stack(
                          children: [
                            Container(
                              // padding: EdgeInsets.only(
                              //   bottom: 24
                              // ),
                              // height: 210,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  "${document.data()['images'][0]}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 16,
                              left: 20,
                              right: 20,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    document.data()['name'] ?? "Product Name",
                                    style: Constants.regHeading,
                                  ),
                                  Text(
                                    // for price use statement below for added
                                    // dollar sign to register.
                                    // "\$${document.data()['price']}"
                                    document.data()['type'][0] ?? "Price",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context).accentColor,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              }

              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );

            },
          ),
          ActionBar(
            title: "Home Page",
            hasBackArrow: false,
          ),
        ],
      ),
    );
  }
}
