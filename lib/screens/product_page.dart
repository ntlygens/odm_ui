import 'package:flutter/material.dart';
import 'package:odm_ui/services/firebase_services.dart';
import 'package:odm_ui/widgets/action_bar.dart';
import 'package:odm_ui/widgets/category_types.dart';
import 'package:odm_ui/widgets/image_swipe.dart';

import '../constants.dart';

class ProductPage extends StatefulWidget {
  final String? productID;
  ProductPage({this.productID});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: _firebaseServices.productsRef.doc(widget.productID).get(),
            // future: _firebaseServices.productsRef.get(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                // List of images
                List _imageList;
                // List of types
                List _categoryType;

                if(snapshot.hasData) {
                  return ListView(
                    padding: EdgeInsets.all(0),
                    children: snapshot.data!.docs.map((documentData) {
                      _imageList = documentData['images'];
                      _categoryType = documentData['type'];
                      Column(
                        children: [
                          ImageSwipe(imageList: _imageList),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 24
                            ),
                            child: Text(
                              "${documentData['name']}",
                              style: Constants.boldHeading,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 24
                            ),

                            child: Text(
                              "${documentData['desc']}",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 24
                            ),
                            child: Text(
                              "Select Type",
                              style: Constants.regHeading,
                            ),
                          ),
                          CategoryTypes(
                            categoryTypeList: _categoryType,
                            serviceCategoryID: "selected-service-id",
                            serviceCategoryName: "selected-service-name",
                          ),
                        ],
                      );

                    }),
                  );
                }
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
