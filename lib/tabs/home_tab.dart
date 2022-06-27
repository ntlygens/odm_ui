import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:odm_ui/constants.dart';
import 'package:odm_ui/screens/selected_service_page.dart';
import 'package:odm_ui/services/firebase_services.dart';
import 'package:odm_ui/widgets/action_bar.dart';

class HomeTab extends StatelessWidget {
  FirebaseServices _firebaseServices = FirebaseServices();
  // HomeTab({});
  late List _srvcData;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Center(
            child: Text("Home Tab"),
          ),
          // FutureBuilder<QuerySnapshot>(
          FutureBuilder(
            future: _firebaseServices.servicesRef
              // .doc()
              // .snapshots()
              .get()
              // .get()
              // .then((value) => value.docs
              // .forEach((element) {
              //   var docRef = element.id;
              //   // docRef.update({'isSelected': false});
              //   // print ("di: ${docRef}");
              //   // _srvcData.add(docRef);
              //   // print ("do: ${_srvcData}");
              //   // return _srvcData;
              // }))
            ,
            builder: (context, AsyncSnapshot acctSrvcSnap) {
              int _totalItems = 0;
              if (acctSrvcSnap.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${acctSrvcSnap.error}"),
                  ),
                );
              }

              // collection data to display
              if(acctSrvcSnap.connectionState == ConnectionState.done) {
                // display data in listview
                if (acctSrvcSnap.hasData) {
                  /*return ListView(
                    padding: EdgeInsets.only(
                      top: 120,
                      bottom: 24,
                    ),
                    children: snapshot.data!.docs.map((document) {
                      return GestureDetector(
                        onTap: () {
                          // print("srvcID: ${document.id}");
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  SelectedServicePage(
                                      serviceID: document.id
                                  )
                          ));
                        },
                        child: Card(
                          elevation: 3,
                          margin: EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 16,
                          ),
                          child: Stack(
                            children: [
                              Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.network(
                                    "${document['images'][0]}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 16,
                                left: 20,
                                right: 20,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text(
                                      document['name'],
                                      style: Constants.regHeading,
                                    ),
                                    */

                  /*Text(
                                      // for price use statement below for added
                                      // dollar sign to register.
                                      // "\$${document.data()['price']}"
                                      document['type'][0],
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Theme
                                              .of(context)
                                              .accentColor,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),*/

                  /*
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );*/

                  List _srvcData = acctSrvcSnap.data!.docs;
                  // print ("srvc: ${acctSrvcSnap.data['name']}");
                  _totalItems = _srvcData.length;
                  print ("$_totalItems & ${_srvcData[1].id}");

                  return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 150,
                        childAspectRatio: 1 / 1,
                        // mainAxisSpacing: 0
                      ),
                      itemCount: _srvcData.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return StreamBuilder(
                          stream: _firebaseServices.sellersRef
                              .doc("${_srvcData[index].id}")
                              .snapshots(),
                          builder: (context, AsyncSnapshot sellerSnap) {

                            if(sellerSnap.connectionState == ConnectionState.active) {
                              if(sellerSnap.hasData) {
                                // print("ID: ${sellerSnap.data.id} \n Name: ${sellerSnap.data['name']}");
                                print("ID: ${sellerSnap.data!.id}");



                                // return ProductWndw(
                                //   sellerID: "${sellerSnap.data['sellerID']}",
                                //   sellerName: "${sellerSnap.data['name']}",
                                //   sellerLogo: "${sellerSnap.data['logo']}",
                                //   prodQty: "${sellerSnap.data['inStockQty']}",
                                //   prodID: "${widget.prodID}",
                                //   prodName: "${widget.prodName}",
                                //   isSelected: sellerSnap.data['hasItem'],
                                // );


                                // print ("srvc: ${sellerSnap}");
                                return Center(
                                  child: Text(
                                    "${sellerSnap.data!.id}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),

                                  ),
                                );

                              }

                            }

                            return Scaffold(
                              body: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                        );
                      }
                  );

                }

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
