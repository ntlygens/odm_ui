import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:odm_ui/widgets/action_bar.dart';

class HomeTab extends StatelessWidget {
  final CollectionReference _productsRef =
    FirebaseFirestore.instance.collection("Products");
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
            future: _productsRef.get(),
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
                    return Container(
                      // height: 225,
                      // width: double.infinity,
                      // alignment: Alignment.topCenter,
                      margin: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 12,
                      ),
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              bottom: 24
                            ),
                            // height: 210,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                "${document.data()['images']}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 10,
                            right: 10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Product Name"),
                                Text("Price"),
                              ],
                            ),
                          )
                        ],
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
