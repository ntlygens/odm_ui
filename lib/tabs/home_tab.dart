import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:odm_ui/constants.dart';
import 'package:odm_ui/screens/selected_service_page.dart';
import 'package:odm_ui/services/firebase_services.dart';
import 'package:odm_ui/widgets/action_bar.dart';
import 'package:odm_ui/widgets/product_wndw.dart';

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
                  List _srvcData = acctSrvcSnap.data!.docs;
                  // print ("srvc: ${acctSrvcSnap.data['name']}");
                  _totalItems = _srvcData.length;
                  print ("$_totalItems & ${_srvcData[1]['name']}");

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
                              .doc()
                              // .doc("${_srvcData[index].id}")
                              .snapshots(),
                          builder: (context, AsyncSnapshot srvcsSnap) {

                            if(srvcsSnap.connectionState == ConnectionState.active) {
                              if(srvcsSnap.hasData) {
                                // print("ID: ${srvcsSnap.data.id} \n Name: ${srvcsSnap.data['name']}");
                                // print("ID: ${srvcsSnap.data!.id}");
                                print("ID: ${_srvcData[index]['name'] }");

                                return ProductWndw(
                                  sellerID: "${_srvcData[index].id}",
                                  sellerName: "${_srvcData[index]['name']}",
                                  sellerLogo: "${_srvcData[index]['images'][0]}",
                                  prodID: "${_srvcData[index].id}",
                                  prodName: "${_srvcData[index]['name']}",
                                  isSelected: true,
                                );


                                // print ("srvc: ${srvcsSnap}");

                                // return SelectedServicePage(serviceID: srvcsSnap.data!.id);


                                // return Center(
                                //   child: Text(
                                //     "${srvcsSnap.data!.id}",
                                //     style: TextStyle(
                                //       fontSize: 16,
                                //       fontWeight: FontWeight.w600,
                                //       color: Colors.black,
                                //     ),
                                //
                                //   ),
                                // );

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
